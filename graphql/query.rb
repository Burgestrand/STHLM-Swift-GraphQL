class Query < GraphQL::Schema::Object
  description "Root query type. There's only one."

  field :me, type: Types::Me, null: true do
    description "The currently authorized user."
  end

  field :users, type: [Types::User], null: false do
    description "A list of all users."
  end

  field :user, type: Types::User, null: true do
    description "Retrieve a user by ID."

    argument :id, type: ID, required: true
  end

  field :movies, type: [Types::Movie], null: false do
    description "A list of all movies."
  end
end
