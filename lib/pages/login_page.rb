require_relative 'base_page'

class LoginPage < BasePage

  LOGIN_FIELD    = {id: 'user_login'}
  PASSWORD_FIELD = {id: 'user_pass'}
  LOGIN_BUTTON   = {id: 'wp-submit'}

  def initialize(driver)
    super
    # verify_page
  end

  def login(username, password)
    visit '/login'
    type LOGIN_FIELD, username
    type PASSWORD_FIELD, password
    click_on LOGIN_BUTTON
  end

  def check_page
    title.include?('WordPress').should == true
  end

  private

  def verify_page
    title.include?('WordPress').should == true
  end

end