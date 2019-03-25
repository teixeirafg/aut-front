require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require 'capybara/cucumber'
require 'pry'
require 'faker'
require 'cpf_faker'
require 'brstring'
require 'fileutils'
require 'logger'
require 'capybara-screenshot/rspec'
require 'site_prism'
require 'base64'
require 'correios-cep'

#require_relative '../../aut-api-rest/features/support/apirest'
PATH_API_REST = 'aut-api-rest/'
require_relative '../../aut-api-rest/lib/apirest/apirest'

Dir[File.join(File.dirname(__FILE__), 'spec_helper/*.rb')].sort.each {|file| require file}
Dir[File.join(File.dirname(__FILE__), 'elements/**/*.rb')].sort.each {|file| require file}
Dir[File.join(File.dirname(__FILE__), 'assertion/*.rb')].sort.each {|file| require file}
Dir[File.join(File.dirname(__FILE__), 'utils/*.rb')].sort.each {|file| require file}

ENV['AMBIENTE'] ? AMBIENTE = ENV['AMBIENTE'] : 'Ambiente não informado'
ENV['MOBILE'].nil? ? MOBILE = false : MOBILE = true
ENV['LOG_FULL'].nil? ? LOG_FULL = false : LOG_FULL = true


DOMINIO ||= YAML.load_file('features/support/data/config/dominio_bandeira.yml')
DATA ||= YAML.load_file('features/support/data/config/links.yml')

SERVER_STAGE ||= ENV['SERVER_STAGE'] ||= ''
VM_NODE ||= ENV['VM_NODE'] ||= ''
BROWSER ||= ENV['BROWSER']
BANDEIRA ||= ENV['BANDEIRA']
HEADLESS ||= ENV['HEADLESS'] || false

REMOTE ||= ENV['REMOTE'] || false

LARGURA ||= ENV['LARGURA'] ||= '360'
ALTURA ||= ENV['ALTURA'] ||= '640'

Capybara.register_driver :selenium do |app|
  caps = Selenium::WebDriver::Remote::Capabilities.chrome
  caps['pageLoadStrategy'] = 'none'

  if REMOTE
    unless VM_NODE.empty?
      puts "============================= INICIANDO O TESTE NA VM: #{VM_NODE} ============================="
      caps['applicationName'] = VM_NODE
    end

    Capybara::Selenium::Driver.new(app, browser: :chrome, url: 'http://porto001.dc.nova:4446/wd/hub', options: chrome_options(),
                                   desired_capabilities: caps)
  else
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options(),
                                   desired_capabilities: caps)
  end

end

private

def chrome_options()
  options = Selenium::WebDriver::Chrome::Options.new

  unless SERVER_STAGE.empty?
    options.add_argument("--host-resolver-rules= #{SERVER_STAGE}")
  end


  if MOBILE
    mobile_emulation = {user_agent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1'}
    options.add_emulation(mobile_emulation)
    options.add_argument("window-size=#{LARGURA},#{ALTURA}")
  end
  options.add_argument('ignore-certificate-errors')
  options.add_argument('disable-popup-blocking')
  options.add_argument('disable-web-security')
  options.add_argument('disable-infobars')

  if HEADLESS
    options.add_argument('headless')
    options.add_argument('disable-gpu')
    options.add_argument('window-size=1600,1300')
  end
  options
end

Capybara.configure do
  Capybara.default_driver = :selenium
  Capybara.page.driver.browser.manage.window.maximize unless MOBILE
end

World(Comercio, Commons, ClickEl, SendKeys, Select, CheckVisibility, CheckData, FindEl, REST, AssertAndPrint)
