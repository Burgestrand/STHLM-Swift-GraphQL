class Types::Movie < GraphQL::Schema::Object
  field :id, ID, null: false
  field :title, String, null: false
  field :poster_url, Types::Url, null: false
end
