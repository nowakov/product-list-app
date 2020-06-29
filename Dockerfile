FROM ruby:2.7.1-buster

# Create directory for the app
WORKDIR /ruby/product-list-app

# Check for changes in gems and run bundle install if necessary
COPY Gemfile* ./
RUN gem install bundler -v 1.17.3 && bundle install

# Add /bin to PATH
ENV PATH="/ruby/product-list-app/bin:${PATH}"

# Add entrypoint for running commands when container is started
ADD docker-entrypoint.sh /bin/
ENTRYPOINT ["/bin/docker-entrypoint.sh"]
