# README
[![Maintainability](https://api.codeclimate.com/v1/badges/1b4e8b22952f96485111/maintainability)](https://codeclimate.com/github/gr1d99/IAPS-backend/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/1b4e8b22952f96485111/test_coverage)](https://codeclimate.com/github/gr1d99/IAPS-backend/test_coverage)

Heroku: [https://iaas-backend-staging.herokuapp.com](https://iaas-backend-staging.herokuapp.com)


**Note:** redis caching is not available in this staging branch, it is only available in the master branch.

## Requirements
1. Redis([https://redis.io/](https://redis.io/))
2. Docker(optional)([https://www.docker.com/](https://www.docker.com/))


## Development Setup

1. Create an empty file named `.env.development.local` and copy the contents of `.env.development.local.example` to the new file you just created.
2. Update variables in `.env.development.local` with real values.
3. Install dependencies `bundle install`
4. Create databases `rake db:create`
5. Migrate database `rake db:migrate`
6. Seed database `rake db:seed`
7. Start server `foreman start -f Procfile.dev`

**Docker**
1. Create an empty file named `.docker-dev.env` and copy the contents of `.docker-dev.env.example` to the new file you just created.
2. Update variables in `.docker-dev.env` with real values.
3. build image `docker-compose build`
4. start container `docker-compose up`
5. create database `docker-compose exec -e "RAILS_ENV=development" web rake db:create`
6. create database `docker-compose exec -e "RAILS_ENV=development" web rake db:migrate`

## Testing
1. Create an empty file named `.env.test.local` and copy the contents of `.env.test.local.example` to the new file you just created.
2. Update variables in `.env.test.local` with real values.
3. Run `bundle exec rspec`
