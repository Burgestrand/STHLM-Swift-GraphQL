#!/usr/bin/env ruby

require "bundler/setup"

require "sinatra"
require "graphql"

get "/" do
  "Hello world!"
end
