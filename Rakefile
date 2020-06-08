# frozen_string_literal: true

require "rake/testtask"

task :code_analysis do
  sh 'bundle exec rubocop lib test'
  sh 'bundle exec reek lib'
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end
