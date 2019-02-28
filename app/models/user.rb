module Models
  class User < Model
    NAME_FORMAT = %r"\A[a-z0-9\-]{1,64}\z"

    one_to_many :reviews

    def validate
      super

      validates_unique :id
      validates_presence :name
      validates_format NAME_FORMAT, :name, message: "must match #{NAME_FORMAT}"
    end
  end

  User.blueprint do
    id { SecureRandom.uuid }
    name { Faker::Name.name }
  end
end