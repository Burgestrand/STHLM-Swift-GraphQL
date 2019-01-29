class Mutation::CreateUser < GraphQL::Schema::Mutation
  # We use an input object to allow for future parameters
  # without breaking old clients.
  class Input < GraphQL::Schema::InputObject
    argument :name, String, required: true
  end

  # Arguments
  argument :input, Input, required: true

  # Return values
  field :user, Query::User, null: false

  def resolve(input:)
    user = Models::User.make(name: input.name, articles: [])
    object.users.append(user)
    { user: user }
  end
end
