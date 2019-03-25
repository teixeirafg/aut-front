module Alerts

  def accept_alert_if_displayed
    page.driver.browser.switch_to.alert.accept rescue Selenium::WebDriver::Error::NoAlertOpenError
  end

  def dismiss_alert_if_displayed
    page.driver.browser.switch_to.alert.dismiss rescue Selenium::WebDriver::Error::NoAlertOpenError
  end

end