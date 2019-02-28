class Mutation::CreateUser < GraphQL::Schema::Mutation
  class Input < GraphQL::Schema::InputObject
    graphql_name "CreateUserInput"

    argument :name, String, required: true
  end

  argument :input, Input, required: true

  field :user, Types::User, null: false

  def resolve(input:)
    user = Models::User.make(name: input.name)
    { user: user }
  end
end
