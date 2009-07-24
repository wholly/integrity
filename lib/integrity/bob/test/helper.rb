require "test/unit"
require "contest"
require "hpricot"

begin
  require "redgreen"
  require "ruby-debug"
rescue LoadError
end

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"),
  File.expand_path(File.dirname(__FILE__) + "/../test/helper"))

require "bob"
require "bob/test"

class Test::Unit::TestCase
  include Bob
  include Bob::Test

  attr_reader :repo

  def setup
    Bob.logger = Logger.new("/dev/null")
    Bob.engine = Bob::Engine::Foreground
    Bob.directory = File.expand_path(File.dirname(__FILE__) + "/../tmp")

    FileUtils.rm_rf(Bob.directory) if File.directory?(Bob.directory)
    FileUtils.mkdir_p(Bob.directory)
  end
end
