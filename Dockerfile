FROM ruby:2.6.5-slim

RUN set -eux; \
    apt-get update -y ; \
    apt-get dist-upgrade -y ; \
    apt-get install gnupg2 git gcc g++ make wget curl --no-install-recommends -y ; \
    apt-get autoremove -y ; \
    apt-get clean -y ; \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app

WORKDIR /app

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

ENV BUNDLER_VERSION 1.17.3

RUN gem install bundler --version "$BUNDLER_VERSION" --force

RUN bundle install

COPY . .

EXPOSE 9292/tcp

CMD ["bundle", "exec", "rackup"]
