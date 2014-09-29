# require 'cucumber/rake/task'
# require 'yaml'
# require 'json'
# require 'capybara'
#
# @browsers = YAML.load_file('browsers.yml').map { |k, v| v }
# @browsers.each { |browser| p browser }
#
# Cucumber::Rake::Task.new :bs do |task|
#   task.fork = false
#   @browsers.each do |browser, options|
#     Capybara.register_driver(browser.to_sym) do |app|
#       capabilities = Selenium::WebDriver::Remote::Capabilities.new
#       capabilities['os'] = options.fetch('os', 'null')
#       capabilities['os_version'] = options.fetch('os_version', 'null')
#       capabilities['browser'] = options.fetch('browser', 'null')
#       capabilities['browser_version'] = options.fetch('browser_version', 'null')
#       capabilities['device'] = options.fetch('device', 'null')
#       capabilities['browserstack.local'] = 'true'
#       capabilities['browserstack.debug'] = 'true'
#       capabilities['project'] = AppConfig.project
#       Capybara::Selenium::Driver.new(app,
#                                      browser: :remote,
#                                      url: "http://tescostoresltd1:SNH6J2M83rSukN8p9ztC@hub.browserstack.com/wd/hub",
#                                      desired_capabilities: capabilities)
#     end
#   end
# end

require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'parallel'
require 'json'

@browsers = YAML.load_file('browsers.yml').map { |k, v| v.values }.flatten
@parallel_limit = ENV["nodes"] || 3
@parallel_limit = @parallel_limit.to_i

task :cucumber do
  Parallel.map(@browsers, :in_processes => @parallel_limit) do |browser|
    begin
      puts "Running with: #{browser.inspect}"
      ENV['SELENIUM_BROWSER'] = browser['browser']
      ENV['SELENIUM_VERSION'] = browser['browser_version']
      ENV['BS_AUTOMATE_OS'] = browser['os']
      ENV['BS_AUTOMATE_OS_VERSION'] = browser['os_version']

      Rake::Task[:run_features].execute()
    rescue RuntimeError => e
      puts "Error while running task"
    end
  end
end

Cucumber::Rake::Task.new(:run_features)
task :default => [:cucumber]
