module Models
  class Review < Model
    many_to_one :movie
    many_to_one :user

    def validate
      super
      validates_integer :rating
      validates_includes (1..7), :rating
    end
  end

  Review.blueprint do
    id { SecureRandom.uuid }
    rating { SecureRandom.random_number(1..7) }
    movie { Movie.make }
    user { User.make }
  end
end
