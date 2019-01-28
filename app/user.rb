class User < Model
  attr_accessor :id
  attr_accessor :name
end

User.blueprint do
  id { SecureRandom.uuid }
  name { Faker::Name.name }
end
