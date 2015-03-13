Given(/^I want to use cucumber$/) do
  visit root_path
end

When(/^I run the tests$/) do
  
end

Then(/^everything works as a cosmic puzzle$/) do
  expect(page).to have_content "Diabetes App"
end
