#Givens

Given /^I am on the new reservation page\.$/ do
  visit new_reservation_path
end

#Whens
When /^I fill in the following:$/ do |form|
  rows = form.raw

  rows.each do |r|
    fill_in r[0], with: r[1]
  end
end

When /^I press "(.*?)"$/ do |action|
  click_button action
end

#Thens

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end
