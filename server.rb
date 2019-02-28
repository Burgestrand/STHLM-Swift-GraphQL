#!/usr/bin/env ruby

require_relative "boot"

#
# Server code below!
#
before do
  $loader.reload
end

set :static, false
set :run, false

post "/graphql" do
  json = JSON.parse(request.body.read)

  current_user_id = json.dig("variables", "$current_user")
  current_user = Models::User.where(id: current_user_id).first if current_user_id

  result = Schema.execute(
    json["query"],
    variables: json["variables"],
    context: {
      current_user: current_user
    },
    root_value: App.new(
      db: $db,
      current_user: current_user
    )
  )

  json result.to_h
end

Iodine.listen(
  port: ENV.fetch("PORT", 3000),
  service: :http,
  public: "public/",
  handler: Sinatra::Application
)
Iodine.threads = 1
Iodine.workers = 1
Iodine.start