FROM ruby:2.5.1-alpine

RUN apk update && apk upgrade && apk add --no-cache build-base postgresql-dev bash tzdata ncurses file less

RUN bundle config --global frozen 1

ENV APP_PATH=/app

RUN mkdir $APP_PATH

WORKDIR $APP_PATH

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 2.0.1

ENV BUNDLER_VERSION 2.0.1

RUN bundle install

COPY . .

COPY entrypoint.sh /usr/bin

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0" ]
