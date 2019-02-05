# A protocol handler for Iodine raw connection.
class PubSubProtocol
  def initialize(app)
    @app = app

    # Allows us to explicitly unsubscribe when we disconnect.
    @subscription_ids = []
  end

  def on_open(client)
    client.write "Welcome.\n"
  end

  def on_close(client)
    @subscription_ids.each do |subscription_id|
      ::Schema.subscriptions.delete_subscription(subscription_id)
    end
  end

  def on_shutdown(client)
    client.write "Server is shutting down. Bye.\n"
  end

  def on_message(client, buffer)
    context = { client: client }
    result = ::Schema.execute(buffer, root_value: @app, context: context)

    if context[:subscription_id]
      @subscription_ids << context[:subscription_id]
    end

    client.write(result.to_h.to_json + "\n")
  end

  def ping(client)
    # No-op, for now.
  end
end
