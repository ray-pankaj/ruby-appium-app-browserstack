require 'rubygems'
require 'appium_lib'
require 'selenium-webdriver'

username = 'pankajahuja1'
access_key = 'aCxhDStUopf8tsyz4d55'

caps = {}
caps['build'] = 'Ruby Appium Sample'
caps['name'] = 'single_test'
caps['device'] = 'Google Pixel'
caps['platformName'] = 'android'
caps['browserstack.debug'] = true
caps['app'] = ENV['BROWSERSTACK_APP_ID'] || 'bs://<hashed app-id>'
print caps['app']

appium_driver = Appium::Driver.new({
	'caps' => caps,
	'appium_lib' => {
		:server_url => "http://#{username}:#{access_key}@hub-cloud.browserstack.com/wd/hub"
	}}, true)
driver = appium_driver.start_driver

wait = Selenium::WebDriver::Wait.new(:timeout => 30)
wait.until { driver.find_element(:accessibility_id, "Search Wikipedia").displayed? }
element = driver.find_element(:accessibility_id, "Search Wikipedia")
element.click

wait.until { driver.find_element(:id, "org.wikipedia.alpha:id/search_src_text").displayed? }
search_box = driver.find_element(:id, "org.wikipedia.alpha:id/search_src_text")
search_box.send_keys("BrowserStack")
sleep 5

results = driver.find_elements(:class, "android.widget.TextView")
if results.count > 0
	puts "Found results - Test Passed"
else
	puts "No results found - Test Failed"
end

driver.quit
