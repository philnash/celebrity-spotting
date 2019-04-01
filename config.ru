require "bundler"
Bundler.require

Envyable.load("./config/env.yml") unless ENV["RACK_ENV"] == "production"

require "./app.rb"

run CelebritySpotting
