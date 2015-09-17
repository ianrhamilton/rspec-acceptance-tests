require 'selenium-webdriver'
require 'rspec'
require 'rspec-rerun/tasks'
require 'allure-rspec'
require 'pathname'
require 'uuid'
require 'capybara/rspec'
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
  config.after(:each) do |example|
    if example.exception
      example.attach_file('screenshot', File.new(
          @driver.save_screenshot(
              File.join(Dir.pwd, "report/#{UUID.new.generate}.png"))))
    end
  end
  config.after(:all) { @driver.close unless @driver.nil? }
end

AllureRSpec.configure do |config|
  config.output_dir = 'report'
  config.clean_dir = false
end

def browser
  case ENV['browser']
    when 'firefox'
      Selenium::WebDriver.for :firefox
    when 'chrome'
      Selenium::WebDriver::Chrome::Service.executable_path = File.join(Dir.pwd, 'vendor/chromedriver_mac')
      Selenium::WebDriver.for :chrome
    else
      Selenium::WebDriver.for :firefox
  end
end
