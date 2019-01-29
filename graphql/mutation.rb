class Mutation < GraphQL::Schema::Object
  description "Root mutation type. There's only one."

  field :create_user, mutation: Mutation::CreateUser
end
