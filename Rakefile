require 'rake'
require 'rspec/core/rake_task'

desc 'Run all tests'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ["--format progress","--color"]
  t.pattern = ['spec/*.rb']
end

task :default => :spec

# require 'rake'
# require 'rspec/core/rake_task'
#
# desc 'Run all tests'
# RSpec::Core::RakeTask.new(:spec) do |t|
#   t.rspec_opts = ["--format progress","--color", "--format html --out reports/rspec_results.html"]
#   t.pattern = ['spec/*.rb']
# end
#
# namespace :rspec_report do
#   desc 'Run all specs and generate RSpec report in HTML'
#   task :html => :spec
#
#   desc 'Run all specs, generate RSpec report and open it in the browser'
#   task :browser do
#     Rake::Task[:spec].invoke
#     `open reports/rspec_results.html` # This only works if running OS X.
#   end
# end
#
# task :default => :spec