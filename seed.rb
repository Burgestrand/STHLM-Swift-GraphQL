#!/usr/bin/env ruby

require_relative "boot"

# Create fake data!
$db.transaction do
  user = Models::User.make.then(&:save)
  movie = Models::Movie.make.then(&:save)
  Models::Review.make(user: user, movie: movie).then(&:save)
end