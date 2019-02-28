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
config = YAML.load(File.read("./config/database.yml"))
default = config.fetch(:default) do
  raise "Database config fail: #{config}"
end
$db = Sequel.connect(default)