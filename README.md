# Spider-Gazelle To-Do Application

[![Build Status](https://travis-ci.com/polonski/hello-spider-gazelle.svg?branch=master)](https://travis-ci.com/polonski/hello-spider-gazelle)

Auto-building as [Heroku app](https://todobackend-crystal.herokuapp.com/) 

Clone this repository to start building your own spider-gazelle based application

## Documentation

Detailed documentation and guides available: https://spider-gazelle.net/

* [Action Controller](https://github.com/spider-gazelle/action-controller) base class for building [Controllers](http://guides.rubyonrails.org/action_controller_overview.html)
* [Active Model](https://github.com/spider-gazelle/active-model) base class for building [ORMs](https://en.wikipedia.org/wiki/Object-relational_mapping)
* [Habitat](https://github.com/luckyframework/habitat) configuration and settings for Crystal projects
* [router.cr](https://github.com/tbrand/router.cr) base request handling
* [Radix](https://github.com/luislavena/radix) Radix Tree implementation for request routing
* [HTTP::Server](https://crystal-lang.org/api/latest/HTTP/Server.html) built-in Crystal Lang HTTP server
  * Request
  * Response
  * Cookies
  * Headers
  * Params etc
* Usng [Clear ORM](https://clear.gitbook.io/) for model handling.
* Using Postgres Database

Spider-Gazelle builds on the amazing performance of **router.cr** [here](https://github.com/tbrand/which_is_the_fastest).:rocket:


## Testing

`crystal spec`

* to run in development mode `crystal ./src/app.cr`
* passes tests from [ToDoBackend](http://todobackend.com/specs/index.html?https://todobackend-crystal.herokuapp.com/)

## Compiling

`crystal build ./src/app.cr`

### Deploying

Once compiled you are left with a binary `./app`

* for help `./app --help`
* viewing routes `./app --routes`
* run on a different port or host `./app -b 0.0.0.0 -p 80`
