def create_messages(times)
  times.times do
    create(:message)
  end
end

# Given

Given /^There are (.+) messages$/ do |count|
  unless count == "no"
    create_messages count.to_i
  end
end

# Then

Then /^I should see recent messages$/ do
  page.should have_selector('#bb-messages ul li')
end

Then /^I should see messagebox$/ do
  page.should have_selector('#bb-sendbox textarea')
end

Then /^I should see messages placeholder$/ do
  page.find('#bb-messages ul li').should have_content('No messages')
end
