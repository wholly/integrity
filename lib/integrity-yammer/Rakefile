require 'rubygems'
require 'rake'

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

require 'spec/rake/spectask'
 
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ["--color", "--format", "progress"]
  t.spec_files = Dir['spec/**/*_spec.rb'].sort
  t.libs = ['lib']
  t.rcov = false
end
 

