require 'selenium-webdriver'
require 'rspec'
require 'rspec-rerun/tasks'
require 'allure-rspec'
require 'pathname'
require 'uuid'
require 'capybara/rspec'
require 'parallel_tests'
require 'pry'
require 'phantomjs'
require_relative 'site'
require_relative '../../lib/pages/base_page'
require_relative '../../lib/pages/login_page'
require_relative '../../lib/pages/home_page'

RSpec.configure do |config|
  config.include AllureRSpec::Adaptor
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.before(:all) do
    @driver = browser
    @driver.manage.delete_all_cookies
    @site = Site.new(@driver)

  end
  config.after(:all) { @driver.close unless @driver.nil? }
end

AllureRSpec.configure do |c|
  c.output_dir = "log/screenshots"
  c.clean_dir = false
end

ParallelTests.first_process? ? FileUtils.rm_rf(AllureRSpec::Config.output_dir) : sleep(1)

def browser
  case ENV['DRIVER']
    when 'firefox'
      Selenium::WebDriver.for :firefox
    when 'chrome'
      Selenium::WebDriver::Chrome::Service.executable_path = File.join(Dir.pwd, 'vendor/chrome/chromedriver_mac')
      Selenium::WebDriver.for :chrome
    when 'phantomjs'
      # Selenium::WebDriver::PhantomJS.path = File.join(Dir.pwd, 'vendor/phantom/phantomjs')
      Selenium::WebDriver.for :phantomjs
    else
      Selenium::WebDriver.for :firefox
  end
end
