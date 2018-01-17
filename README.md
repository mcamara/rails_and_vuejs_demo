# Rails + VueJS2 Demo
Tests: [![CircleCI](https://circleci.com/gh/mcamara/rails_and_vuejs_demo.svg?style=svg)](https://circleci.com/gh/mcamara/rails_and_vuejs_demo)

[Link to the test app](https://rails-and-vuejs-demo.herokuapp.com)

Built using Vue, Ruby on Rails 5.1 and Heroku (among others).

To test it, just clone it, create an application.yml file with the next value:
```
  database_host: 'your_database_name'
```

Run the following commands:

```
gem install bundle
bundle
rake db:create && rake db:migrate && rake db:seed
yarn
foreman start
```

And open [http://localhost:3000/](http://localhost:3000/) in your browser to find it


### Things to do in the future (or not)
- Vue tests
- Error handling
