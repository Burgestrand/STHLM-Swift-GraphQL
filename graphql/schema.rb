class Schema < GraphQL::Schema
  query ::Query
  mutation ::Mutation
end
