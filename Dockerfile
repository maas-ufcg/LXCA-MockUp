FROM ruby:2.3

RUN mkdir -p /var/apps/lxca-mockup

ADD . /var/apps/lxca-mockup
WORKDIR /var/apps/lxca-mockup
RUN rm Dockerfile
RUN bundle install

CMD ["bundle", "exec", "rails", "server"]
