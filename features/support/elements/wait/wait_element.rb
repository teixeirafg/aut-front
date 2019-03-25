module WaitElement

  def wait_until_el_displayed(finder, el, seconds = 2)
    begin
      options = {}
      options[:timeout] ||= seconds
      wait = Selenium::WebDriver::Wait.new(options)
      element = wait.until {
        element = page.find(finder, el)
      }
      element if element.visible?
    rescue Capybara::ElementNotFound
    end
  end
end