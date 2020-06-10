# Work Time Management

Simple working time/hourse management system

## How to install

 **Requiriments (for dockerized dev env)** 
 - Docker
 - docker-compose
 - MySQL runing in some server (docker or local)

### RUNNING WITH DOCKER

ps: You will be not necessary install MySQL, the docker-compose file already has the config to run the database

1 - Clone or download this repo [Download Link](https://github.com/jorgedjr21/work_time_management/releases)

2 - Open the repo folder and them
```shell
  docker-compose build
  docker-compose run --rm web sh
  
  # Inside the docker-container
  bundle install && rails db:setup
  exit
```

3 - After exiting the container

```shell
  docker-compose up
```

### RUNNING LOCALLY

Run the project localy: (ps: You will need rails and bundler installed in your machine!)

1 - Clone or download this repo [Download Link](https://github.com/jorgedjr21/work_time_management/releases)

2 - Configure the database.yml file inside the config/ folder

```yml
  default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: # UPDATE THE PASSWORD TO YOUR LOCAL DB USER
  password: # UPDATE THE PASSWORD TO YOUR LOCAL DB PASSWORD
  host: # UPDATE THE PASSWORD TO YOUR LOCAL DB HOST
```

3 - Install gems, create the database and the migrations

```shell
  bundle install && rails db:setup
```

4 - Up the application and access it

```shell
  rails s -b 0.0.0.0 -p 3000
```

## Tests and Coverage

- The tests are inside the folder `spec/`

- To run the tests, you can use this comand (inside docker or locally, depends how you run the application):

```shell
bundle exec rspec
```

- Aplication has **100%** of coverage actually
