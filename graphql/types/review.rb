class Types::Review < GraphQL::Schema::Object
  field :id, ID, null: false

  field :rating, Integer, null: false do
    description "What did you think of the movie? 1 to 7!"
  end

  field :notes, String, null: true do
    description "An optional elaboration on what you thought."
  end

  field :movie, Types::Movie, null: false do
    description "Which movie is this?"
  end
end