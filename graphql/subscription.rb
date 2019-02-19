class Subscription < GraphQL::Schema::Object
  description "Root subscription type. There's only one."

  field :time, String, null: false do
    description "Just a property to test pings."
  end

  def time
    # We allow it. Return value is ignored. We may raise to abort.
  end
end
