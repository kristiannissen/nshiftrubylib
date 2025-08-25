require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
end

desc "Run tests"
task default: :test

task :check do
  p "Testing single test case"
  `ruby -I test test/*.rb`
end
