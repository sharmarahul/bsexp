Given(/^I am on Google homepage$/) do
  @homepage = Homepage.new
  @homepage.load
end
