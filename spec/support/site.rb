class Site
  attr_reader :driver

  def initialize(driver)
    @driver = driver
  end

  def login_page
    @login_page ||= LoginPage.new(@driver)
  end

  def home_page
    @home_page ||= HomePage.new(@driver)
  end

end
