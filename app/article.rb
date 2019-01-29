class Article < Model
  attr_accessor :id
  attr_accessor :title
  attr_accessor :content
  attr_accessor :author
end

Article.blueprint do
  id { SecureRandom.uuid }
  title { Faker::Book.title }
  content { Faker::Community.quotes }
  author { User.make }
end

