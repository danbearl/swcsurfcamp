#Givens

Given /^I am on the new reservation page\.$/ do
  visit new_reservation_path

end

Given /^I am on the login page$/ do
  visit '/log_in'
end

Given /^I am on the home page$/ do
  visit '/'
end

Given /^that user is logged in$/ do
  visit '/log_in'

  fill_in 'email', with: @user.email
  fill_in 'password', with: 'pass'
end

#Whens

When /^I follow "(.*?)"$/ do |link|
  click_link(link)
end

When /^I fill in the following:$/ do |form|
  rows = form.raw

  rows.each do |r|
    fill_in r[0], with: r[1]
  end

end

When /^I select the following:$/ do |form|
  rows = form.raw

  rows.each do |r|
    select r[1], from: r[0]
  end

end

When /^I press "(.*?)"$/ do |action|
  click_button action

end

When /^I choose yes to insurance$/ do
  choose "reservation_insurance_true"

end

#Thens

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "(.*?)"$/ do |text|
  page.should_not have_content(text)
end
