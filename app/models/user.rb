module Models
  class User < Model
    one_to_many :reviews
  end

  User.blueprint do
    id { SecureRandom.uuid }
    name { Faker::Name.name }
  end
end