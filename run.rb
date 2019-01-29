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

db = {}
db[:users] = Models::User.make(3)
db[:articles] = db[:users].flat_map { |user| user.articles }

before do
  loader.reload
end

post "/graphql" do
  json = JSON.parse(request.body.read)
  result = Schema.execute(json["query"], root_value: App.new(db: db))
  json result.to_h
end

Sinatra::Application.run!
