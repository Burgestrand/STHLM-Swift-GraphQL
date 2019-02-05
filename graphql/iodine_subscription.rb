# A single instance of this class will be initialized
# to manage all our GraphQL subscriptions.
#
# We instantiate this through the GraphQL schema.
class IodineSubscription < GraphQL::Subscriptions
  def initialize(schema:, **rest)
    @subscribers = {}
    super(schema: schema, **rest)
  end

  # Called when a subscription query comes in.
  def write_subscription(query, events)
    query.context[:subscription_id] ||= build_id
    subscription_id = query.context.fetch(:subscription_id)

    # Save subscription query data for later.
    @subscribers[subscription_id] = query

    # Start observing each event globally.
    events.each do |event|
      Iodine.subscribe(event.topic) do |source, message|
        puts "Execute: #{subscription_id}"
        execute(subscription_id, event, message)
      end
    end
  end

  # Yield each subscription ID that is subscribed to event updates.
  #
  # Called whenever we trigger an event on our subscriptions, to deliver
  # updates to all relevant clients.
  def each_subscription_id(event)
    @subscribers.each do |subscription_id, _|
      yield subscription_id
    end
  end

  # Read the query performed by the subscription.
  #
  # It will be performed again, and results delivered.
  def read_subscription(subscription_id)
    query = @subscribers.fetch(subscription_id) do
      raise GraphQL::Schema::Subscription::UnsubscribedError
    end

    return {
      query_string: query.query_string,
      variables: query.provided_variables,
      context: query.context.to_h,
      operation_name: query.operation_name,
    }
  end

  # Deliver the result hash to the subscriber.
  def deliver(subscription_id, result)
    query = @subscribers[subscription_id]
    return if query.nil?
    payload = result.to_h
    query.context.fetch(:client).write(">> #{payload.to_json}\n")
  end

  # Called from within the server to unsubscribe a client.
  def delete_subscription(subscription_id)
    @subscribers.delete(subscription_id)
  end
end
