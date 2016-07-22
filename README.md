# Unboxed Web Refresh

## Development setup

This is a static site which uses [middleman](https://github.com/middleman/middleman)

To get things running on your machine:

* ### Clone the repository

    git clone git@github.com:unboxed/ubxd_web_refresh.git


* ###Install Dependencies
    cd ubxd_web_refresh
    bundle install

* ### Start the server
    middleman server

 Active reloading is configured, so the server will listen for changes and refresh the page in your browser.

* ### Making a blog post
    Use `middleman article "[article name]" --blog blog` to create a new blog file.

* ### Making a news post
    Use `middleman article "[article name]" --blog news` to create a new blog file.

## Testing

Using [BrowserStack](https://www.browserstack.com) for compability testing
