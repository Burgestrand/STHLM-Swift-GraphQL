module Models
  class Movie < Model
  end

  Movie.blueprint do
    id { SecureRandom.uuid }
    title { Faker::Book.unique.title }
    poster_url do
      categories = %w[city people animals nature sports technics]
      images = (1...10).to_a
      "http://lorempixel.com/320/480/#{categories.sample}/#{images.sample}/#{URI.escape(object.title)}"
    end
  end
end
