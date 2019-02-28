#!/usr/bin/env ruby

require_relative "boot"

Sequel.extension :migration
Sequel::Migrator.run($db, "app/db")