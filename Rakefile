# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |t|
  t.libs.push %w[test lib]
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

RuboCop::RakeTask.new

desc 'Default Task'
task default: %i[test rubocop]
