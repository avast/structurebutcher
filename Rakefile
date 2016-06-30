require 'rake/testtask'
$:.unshift 'lib'

Rake::TestTask.new do |t|
      t.libs << 'test'
      t.pattern = 'test/*.rb'
      t.verbose = true
end

desc "Run tests"
task :default => :test
