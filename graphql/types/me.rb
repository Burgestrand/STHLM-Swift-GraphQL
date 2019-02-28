class Types::Me < Types::User
  field :reviews, type: [Types::Review], null: false do
    description "All of your reviews!"
  end
end