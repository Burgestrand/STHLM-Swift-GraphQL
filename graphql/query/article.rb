class Query::Article < GraphQL::Schema::Object
  field :id, ID, null: false
  field :title, String, null: false
  field :content, String, null: false
  field :author, Query::User, null: false
end
