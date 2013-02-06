
# factory girl
include FactoryGirl::Syntax::Methods

Given /^I have some seed data$/ do
  load "#{Rails.root}/db/seeds.rb"
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

And /^I submit my selection$/ do
  step %{I finalize my selection of ingredients}
  step %{I submit my sandwich selection}
end
Then /^I should see a page with various sandwich types$/ do
  page.should have_content 'Containers'
  page.should have_content 'Meats'
  page.should have_content 'Veggies'
end

When /^I choose a veggie theme$/ do
  select('Veggie', :from=>'theme')
  meat = Meat.veggie.first
  cheese = Cheese.last
  has_checked_field?('i' + meat.id.to_s).should be(true)
  has_checked_field?('i' + cheese.id.to_s).should be(true)
end

And /^I finalize my selection of ingredients$/ do
  v = Vegetable.last
  check("i#{v.id}")
end

And /^I submit my sandwich selection$/ do
  click_button('Submit')
end

Then /^I should see a "(.*?)" sandwich in the list$/ do |sandwich_type|
  page.should have_content sandwich_type
  ActionMailer::Base.deliveries = []
end

And /^I finish my order$/ do
  step %{I can then confirm my order}
  step %{I am redirected to a thank you page with a snappy quote}
  step %{I should generate an email of my order}
end

And /^I can then confirm my order$/ do
  SnappyQuote.should_receive(:get_one).at_least(1) {"Snappy little quip"}
  click_button('Submit Order')
end

And /^I am redirected to a thank you page with a snappy quote$/ do
  page.should have_content 'Thank you for your Order'
end

And /^I should generate an email of my order$/ do
  ActionMailer::Base.deliveries.size.should eq(1)
end

Given /^I am on the Order History Page$/ do
  @sandwich = Sandwich.meaty
  @order = Order.create(user_id: @user.id)
  @order.sandwiches << @sandwich
  p @order.sandwiches
  @order.valid?.should be(true)
  @order.save!
  visit("/orders")
  page.should have_content 'Listing orders'
end

Given /^I select a past order$/ do
  visit("/orders/1")
  page.should have_content 'Listing sandwiches for your Past Order'
  click_link('copy_sandwich')
end

Then /^I should see the sandwich ingredients pre\-selected$/ do
  Meat.meaty.each do |meat|
    has_checked_field?('i' + meat.id.to_s).should be(true)
  end
end
