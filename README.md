# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Instructions
  - Run all tests
    ```
      bundle exec rspec
    ```
  - Development mode (auto reload files, auto run tests)
    ```
      bundle exec guard
    ```
  - Generate model
    ```
      bundle exec rails generate scaffold <model_name> _id:string properties:hash --skip-template-engine
    ```
  - Build docker image
    ```
      docker build . -t <image_name>
    ```
  - Run docker image on localhost:3000
    ```
      docker run --name <container_name> -p 3000:3000 -d <image_name>
    ```

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
