class Query < GraphQL::Schema::Object
  description "Root query type. There's only one."

  field :users, type: [Types::User], null: false do
    description "A list of all users."
  end

  field :user, type: Types::User, null: true do
    description "Retrieve a user by ID."

    argument :id, type: ID, required: true
  end

  field :articles, type: [Types::Article], null: false do
    description "A list of all articles."
  end

  field :article, type: Types::Article, null: true do
    description "Retrieve an article by ID."

    argument :id, type: ID, required: true
  end
end
