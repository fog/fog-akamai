require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push %w(tests)
  t.test_files = FileList['tests/**/*_test.rb']
  t.verbose = true
end

desc 'Default Task'
task default: [:test]
