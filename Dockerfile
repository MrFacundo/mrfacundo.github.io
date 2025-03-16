# Use an official Ruby runtime as a parent image
FROM ruby:3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libvips-tools nodejs npm

# Set the working directory
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN gem install bundler
RUN bundle config set force_ruby_platform true
RUN bundle install --jobs=4 --retry=3

# Copy the rest of the application code
COPY . .

# Install npm dependencies
RUN npm install

# Expose port 4000 to the outside world
EXPOSE 4000

# Command to run the application
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]