FROM ruby:2.6-alpine
RUN apk add --no-cache --update \
  build-base \
  linux-headers \
  nodejs \
  yarn \
  mariadb-dev \
  tzdata \
  graphviz \
  gmp-dev

RUN mkdir /work_time_management
WORKDIR /work_time_management
COPY Gemfile /work_time_management/Gemfile
COPY Gemfile.lock /work_time_management/Gemfile.lock
RUN bundle install
COPY . /work_time_management

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["sh", "entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]