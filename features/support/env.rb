require 'site_prism'
require 'capybara'
require 'selenium-webdriver'

require_relative '../../pages/homepage'

Capybara.register_driver :firefox do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['network.proxy.type'] = 4 # auto detect proxy
  ENV['HTTP_PROXY']=nil
  Capybara::Selenium::Driver.new(app, browser: :firefox, profile: profile)
end

Capybara.register_driver :bs do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['network.proxy.type'] = 4 # auto detect proxy
  ENV['HTTP_PROXY']= 'http://DEV01ISA01:8080'
  capabilities = Selenium::WebDriver::Remote::Capabilities.new
  capabilities['os'] = ENV['BS_AUTOMATE_OS'] || 'null'
  capabilities['os_version'] = ENV['BS_AUTOMATE_OS_VERSION'] || 'null'
  capabilities['browser'] = ENV['SELENIUM_BROWSER'] || 'null'
  capabilities['browser_version'] = ENV['SELENIUM_VERSION'] || 'null'
  capabilities['device'] = ENV['BS_AUTOMATE_DEVICE'] || 'null'
  capabilities['browserstack.local'] = 'true'
  capabilities['browserstack.debug'] = 'true'
  capabilities['project'] = 'MDSI'
  Capybara::Selenium::Driver.new(app,
                                 browser: :remote,
                                 url: "http://tescostoresltd1:SNH6J2M83rSukN8p9ztC@hub.browserstack.com/wd/hub",
                                 desired_capabilities: capabilities)
end

Capybara.configure do |config|
  config.app_host = 'http://google.co.uk'
  config.run_server = false # do not load rack app
  config.default_driver = :bs
end
