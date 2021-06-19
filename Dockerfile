FROM ruby:2.7.1-alpine

RUN apk add --no-cache --update build-base \
	linux-headers \
	tzdata \
	postgresql-dev

RUN mkdir /afm-api
WORKDIR /afm-api

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .
