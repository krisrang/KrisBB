Given /^I wait (\d+) seconds?$/ do |sec|
  sleep(sec.to_i)
end

When /^I go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I wait until all Ajax requests are complete$/ do
  page.evaluate_script('jQuery.active') == 0
end

Then /^I should see "(.*?)"$/ do |arg1|
  page.should have_content(arg1)
end
