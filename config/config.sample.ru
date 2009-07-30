#!/usr/bin/env ruby
require "rubygems"
require "lib/integrity"
#require "lib/integrity-yammer/lib/notifier/yammer"
#Uncomment the above and below lines to use yammer notifier 
#Integrity::Notifier.register(Integrity::Notifier::Yammer)

Integrity.new(File.dirname(__FILE__) + "/config.yml")

# Use a pool of 20 threads for parralel builds
Bob.engine = Bob::Engine::Threaded.new(20)

map "/github/SECRET_TOKEN" do
  use Bobette::GitHub
  run Bobette.new(Integrity::BuildableProject)
end

map "/" do
  run Integrity::App
end
