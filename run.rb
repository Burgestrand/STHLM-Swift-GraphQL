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

post "/graphql" do
  json = JSON.parse(request.body.read)
  result = Schema.execute(json["query"], root_value: App.new(db: db))
  json result.to_h
end

Iodine.on_idle do
  Iodine.subscribe(:time) do |source, message|
    ::Schema.subscriptions.trigger(:time, {}, message)
  end

  next unless Iodine.master?

  Iodine.run_every(1 * 1000) do
    Iodine.publish(:time, Time.now.to_i.to_s)
  end
end

Iodine.listen(port: 3000, service: :http, public: "public/", handler: Sinatra::Application)
Iodine.listen(port: 3001) do
  PubSubProtocol.new(App.new(db: db))
end

Iodine.threads = 1
Iodine.workers = 1
Iodine.start
