#!/usr/bin/env ruby

require_relative "boot"

app = App.new(db: $db)
binding.pry