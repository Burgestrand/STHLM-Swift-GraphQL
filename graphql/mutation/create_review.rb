class Mutation::CreateReview < GraphQL::Schema::Mutation
  class Input < GraphQL::Schema::InputObject
    graphql_name "CreateReviewInput"

    argument :movie_id, ID, required: true
    argument :rating, Integer, required: true do
      description "Your rating, 1 to 7."
    end

    argument :notes, String, required: false do
      description "Extra notes"
    end
  end

  argument :input, Input, required: true

  field :review, Types::Review, null: true
  field :errors, [String], null: true

  def resolve(input:)
    binding.pry

    begin
      review = Models::Review.new(input.to_h)
      review.id = SecureRandom.uuid
      review.user = context[:current_user]

      if review.valid?
        { review: review.save }
      else
        { errors: review.errors.full_messages }
      end
    rescue => error
      raise GraphQL::ExecutionError, error
    end
  end
end
