#!/usr/bin/env ruby

require_relative "boot"

# Create fake data!
$db.transaction do
  100.times do
    Models::Movie.make.then(&:save)
  end
end