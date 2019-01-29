class Query::User < GraphQL::Schema::Object
  field :id, ID, null: false
  field :name, String, null: false
  field :articles, [Query::Article], null: false
end
