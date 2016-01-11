set :relative_links, true
set :layout, 'application'
set :css_dir, 'assets/stylesheets'
set :js_dir, 'assets/javascripts'
set :images_dir, 'assets/images'
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, autolink: true, smartypants: true, underline: true

activate :blog do |blog|
  blog.layout = 'blog_article'
  blog.prefix = 'blog'
  blog.taglink = "{tag}.html"
  blog.permalink = "{title}.html"
  blog.tag_template = 'blog/tag.html'
  blog.new_article_template = 'templates/blog_article.md'
end
activate :similar, algorithm: :related_blog_articles
activate :directory_indexes

configure :development do
  activate :livereload
end

require 'lib/helpers'
helpers Helpers

data.people.each do |person|
  proxy "blog/author/#{person.short_name}.html", "blog_author_grid.html",
    locals: { author_name: person.name }, ignore: true
end

ignore '/templates/*'
ignore '/partials/*'
ignore '/**/README.md'

page "/blog/feed.xml", layout: false
page "/blog/feed.rss", layout: false

configure :build do
  activate :minify_css
  activate :minify_javascript
end

after_build do |builder|
  builder.source_paths << File.dirname(__FILE__)
  builder.copy_file('data/_redirects', 'build/_redirects')
end

activate :s3_sync do |s3_sync|
  # s3_sync.bucket                     = # ENV['AWS_BUCKET']
  # s3_sync.aws_access_key_id          = # ENV['AWS_ACCESS_KEY_ID']
  # s3_sync.aws_secret_access_key      = # ENV['AWS_SECRET_ACCESS_KEY']
  s3_sync.region                     = 'eu-west-1'     # The AWS region for your bucket.
  s3_sync.delete                     = true # We delete stray files by default.
  s3_sync.after_build                = false # We do not chain after the build step by default.
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.version_bucket             = false
  s3_sync.index_document             = 'index.html'
  s3_sync.error_document             = '404.html'
end

# Without this we trigger a bug in s3_sync:
::Rack::Mime::MIME_TYPES['.woff2'] = 'font/woff2'
