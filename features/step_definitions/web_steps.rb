 When /^I go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I wait until all Ajax requests are complete$/ do
  wait_until do
    page.evaluate_script('$.active') == 0
  end
end

Then /^I should see "(.*?)"$/ do |arg1|
  page.should have_content(arg1)
end
