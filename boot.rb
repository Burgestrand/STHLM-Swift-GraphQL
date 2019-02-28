#!/usr/bin/env ruby

require "bundler/setup"
Bundler.require

$loader = Zeitwerk::Loader.new
$loader.push_dir(File.join(__dir__, "app"))
$loader.push_dir(File.join(__dir__, "graphql"))
$loader.setup

# 
# Configure database.
#
$db = Sequel.sqlite(":memory:")
Sequel.extension(:migration)
Sequel::Migrator.run($db, "./app/db/")

def placeholder_url
  categories = %w[city people animals nature sports technics]
  images = (1...10)
  "http://lorempixel.com/320x640/#{categories.sample}/#{images.sample}"
end

# Create fake data!
$db.transaction do
    user = Models::User.make.then(&:save)
    movie = Models::Movie.make.then(&:save)
    Models::Review.make(user: user, movie: movie).then(&:save)
end