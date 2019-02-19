class Schema < GraphQL::Schema
  query ::Query
  mutation ::Mutation
  subscription ::Subscription

  use CustomSubscriptionManager
end
