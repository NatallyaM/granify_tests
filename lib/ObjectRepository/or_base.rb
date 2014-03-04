require_relative 'or_base'

class BasePage
  def initialize(browser)
    @browser = browser
    @wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    
  end
  
end
