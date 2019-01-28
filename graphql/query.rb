class Query < GraphQL::Schema::Object
  field :users, type: [Query::User], null: false do
    description "A list of all users."
  end
end
