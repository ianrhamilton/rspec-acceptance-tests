require_relative 'base_page'

class HomePage < BasePage

  NEW_POST = {link: 'New Post'}

  def initialize(driver)
    super
    verify_page
  end

  def add_new_post
    click_on NEW_POST
  end

  private

  def verify_page
    title.include?('Followed Sites').should == true
  end

end
