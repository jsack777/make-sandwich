
# factory girl
include FactoryGirl::Syntax::Methods

Given /^I have some seed data$/ do
  require "#{Rails.root}/db/seeds.rb"
end

And /^I am logged in$/ do
  # assume I am logged in
  @user = User.first || create(:user)
end

And /^I am directed to a welcome page$/ do
  visit("/")
  page.should have_content 'New Order'
end

When /^I create a new order$/ do
  click_link('New Order')
  page.should have_content 'Add a Sandwich'
  click_link('Add a Sandwich')
end

Then /^I should see a page with various sandwich types$/ do
  page.should have_content 'Containers'
  page.should have_content 'Meats'
  page.should have_content 'Veggies'
end

When /^I select one as my template$/ do
  select('Veggie', :from=>'theme')
end

And /^I finalize my selection of ingredients$/ do
  meat = Meat.veggie.first
  cheese = Cheese.last
  has_checked_field?('i' + meat.id.to_s).should be(true)
  has_checked_field?('i' + cheese.id.to_s).should be(true)
  v = Vegetable.last
  check("i#{v.id}")
end

And /^I submit my sandwich selection$/ do
  click_button('Submit')
end

Then /^I should see my current order sandwich list$/ do
  page.should have_content 'veggie burger'
  ActionMailer::Base.deliveries = []
end

And /^I can then confirm my order$/ do
  click_button('Submit Order')
end

And /^I am redirected to a thank you page with a snappy quote$/ do
  page.should have_content 'Thank you for your Order'
end

And /^I should generate an email of my order$/ do
  ActionMailer::Base.deliveries.size.should eq(1)
  p ActionMailer::Base.deliveries.first
end
