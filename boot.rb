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

database_url = ENV.fetch("DATABASE_URL", "postgres://localhost/meetup")
$db = Sequel.connect(database_url)