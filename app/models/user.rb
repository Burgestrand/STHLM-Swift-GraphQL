module Models
  class User < Model
    one_to_one :review
  end

  User.blueprint do
    id { SecureRandom.uuid }
    name { Faker::Name.name }
  end
end
