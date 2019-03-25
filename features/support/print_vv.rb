require 'cucumber/glue/proto_world'
require 'capybara-screenshot/rspec'

class PrintVV
  include Cucumber
  $screenshot_final = []
  def scenario_print(description, status)
    begin
    timer_path = Time.now.strftime('%Y_%m_%d').to_s
    scenario = $Scenario
    $file_path = "screenshots/#{timer_path}/scenario_run_#{scenario.name}"
    FileUtils.mkdir_p($file_path) unless File.exist?($file_path)


    file_name = description.remover_acentos.gsub(/\s+/, '_').gsub(/\W/, '').downcase
    screenshot = "#{$file_path}/#{file_name}.png"
    Capybara.page.driver.browser.save_screenshot(screenshot)

    screen_hash = { :image => screenshot, :description => "#{status.upcase}: #{description}" }
    $screenshot_final << screen_hash
    rescue StandardError
    end
  end
end