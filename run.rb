#!/usr/bin/env ruby

require "bundler/setup"
Bundler.require

loader = Zeitwerk::Loader.new
loader.push_dir(File.join(__dir__, "app"))
loader.push_dir(File.join(__dir__, "graphql"))
loader.setup

db = {}
db[:users] = Models::User.make(3)

before do
  loader.reload
end

set :static, false
set :run, false

post "/graphql" do
  json = JSON.parse(request.body.read)
  result = Schema.execute(json["query"], root_value: App.new(db: db))
  json result.to_h
end

Iodine.listen(port: ENV.fetch("PORT", 3000), service: :http, public: "public/", handler: Sinatra::Application)
Iodine.threads = 1
Iodine.workers = 1
Iodine.start