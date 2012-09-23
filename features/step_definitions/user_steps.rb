def create_user
  @user = create(:user)
end

def log_in(user = @user)
  visit login_path
  fill_in "Username", with: user[:username]
  fill_in "Password", with: "secret"
  click_button "Sign In"
end

# Given

Given /^I am logged out$/ do
  @user = nil
end

Given /^I am logged in$/ do
  create_user
  log_in
end

Given /^I am logged in as admin$/ do
  @admin = create(:user, admin: true)
  log_in(@admin)
end

Given /^I am registered$/ do
  create_user
end

# When

When /^I edit another user$/ do
  @user = create(:user)
  visit edit_user_path(@user)
end

When /^I delete another user$/ do
  @user = create(:user)
  visit user_path(@user)
  click_link "Delete User"
  #page.driver.browser.switch_to.alert.accept
end

When /^I sign up$/ do
  visit signup_path
  @user = attributes_for(:user)
  password = "secret"
  fill_in "Username", with: @user[:username]
  fill_in "Email", with: @user[:email]
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password
  click_button "Sign Up"
end

When /^I fail to sign up$/ do
  visit signup_path
  click_button "Sign Up"
end

When /^I log in$/ do
  log_in
end

When /^I fail to log in$/ do
  visit login_path
  click_button "Sign In"
end

When /^I log out$/ do
  page.find('.logout-link').click
end

When /^I change my "(.*?)"$/ do |field|
  visit edit_user_path(@user)

  case field
  when "email"
    @new_email = "test@test.com"
    fill_in "Email", with: @new_email
  when "password"
    @new_password = "supersecret"
    fill_in "New password", with: @new_password
    fill_in "Confirm new password", with: @new_password
  end

  click_button "Save"
end

When /^I upload a new avatar$/ do
  visit edit_user_path(@user)
  attach_file 'Set avatar', "#{Rails.root}/features/fixtures/test.png"
  click_button "Save"
end

When /^I upload an invalid avatar$/ do
  visit edit_user_path(@user)
  attach_file 'Set avatar', "#{Rails.root}/features/fixtures/test.gif"
  click_button "Save"
end

When /^I visit my profile page$/ do
  visit user_path(@user)
end

When /^I visit user list$/ do
  visit users_path
end

# Then

Then /^I should see a list of users$/ do
  page.should(have_content("Users")) &&
  page.find('.container').should(have_content(@user[:username]))
end

Then /^I should be logged in$/ do
  page.find('.navbar').should have_content(@user[:username])
end

Then /^I should be logged out$/ do
  page.should have_content("Sign In")
end

Then /^My "(.*?)" should be changed$/ do |field|
  user = User.find(@user.id)

  case field
  when "email"
    user.email == @new_email
  when "password"
    User.authenticate(@user.email, @new_password)
  when "avatar"
    user.avatar.url.should include("test.png")
    page.find('i.avatar img')[:src].should have_content("test.png")
  end
end

Then /^I should see an error on "(.*?)"$/ do |field|
  page.find('.error label').should have_content(field)
end

Then /^I should see my profile$/ do
  page.find('h2').should have_content(@user.username)
end

Then /^I should be able to update the user$/ do
  newemail = "test@test.com"
  fill_in "Email", with: newemail
  click_button "Save"
  user = User.find(@user.id)
  user.email.should eq(newemail)
end

Then /^I should see authorization error$/ do
  page.find(".alert").should have_content("This page requires logging in")
end

Then /^I should not see the user$/ do
  page.should_not have_content(@user.username)
end
