# frozen_string_literal: true

require 'rake/testtask'

task default: :test

Rake::TestTask.new do |task|
  task.libs << 'test'
  task.test_files = FileList['test/**/*_test.rb']
  task.verbose = true
end
