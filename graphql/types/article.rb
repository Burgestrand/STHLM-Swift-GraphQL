class Types::Article < GraphQL::Schema::Object
  field :id, ID, null: false
  field :title, String, null: false
  field :content, String, null: false
  field :author, Types::User, null: false
end
