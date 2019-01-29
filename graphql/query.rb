class Query < GraphQL::Schema::Object
  field :users, type: [Query::User], null: false do
    description "A list of all users."
  end

  field :user, type: Query::User, null: true do
    description "Retrieve a user by ID."

    argument :id, type: ID, required: true
  end

  field :articles, type: [Query::Article], null: false do
    description "A list of all users."
  end
end
