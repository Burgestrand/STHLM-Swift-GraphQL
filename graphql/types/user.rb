class Types::User < GraphQL::Schema::Object
  field :id, ID, null: false
  field :name, String, null: false
  field :articles, [Types::Article], null: false
end
