class Mutation::CreateUser < GraphQL::Schema::Mutation
  class Input < GraphQL::Schema::InputObject
    graphql_name "CreateUserInput"

    argument :id, Types::Uuid, required: false
    argument :name, String, required: true
  end

  argument :input, Input, required: true

  field :user, Types::User, null: true
  field :errors, [String], null: true

  def resolve(input:)
    begin
      user = Models::User.make(input.to_h)

      if user.valid?
        { user: user.save }
      else
        { errors: user.errors.full_messages }
      end
    rescue => error
      raise GraphQL::ExecutionError, error
    end
  end
end
