#!/usr/bin/env ruby

require "bundler/inline"

gemfile do
  source "https://rubygems.org/"

  ruby "~> 2.5.0"

  gem "pry"
  gem "pry-coolline"

  gem "graphql"
  gem "faker"

  gem "sinatra"
  gem "sinatra-contrib"

  gem "machinist"
  gem "zeitwerk"
end

require "sinatra/json"

loader = Zeitwerk::Loader.new
loader.push_dir(File.join(__dir__, "app"))
loader.push_dir(File.join(__dir__, "graphql"))
loader.setup

app_data = {
  users: User.make(5)
}

post "/graphql" do
  json = JSON.parse(request.body.read)
  result = Schema.execute(json["query"], root_value: app_data)
  json result.to_h
end

Sinatra::Application.run!
