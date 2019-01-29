class User < Model
  attr_accessor :id
  attr_accessor :name
  attr_accessor :articles
end

User.blueprint do
  id { SecureRandom.uuid }
  name { Faker::Name.name }
  articles { Article.make(3, author: object) }
end
