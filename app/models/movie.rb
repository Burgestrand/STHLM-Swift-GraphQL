module Models
  class Movie < Model
  end

  Movie.blueprint do
    id { SecureRandom.uuid }
    title { Faker::Book.title }
  end
end
