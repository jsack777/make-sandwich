require 'spec_helper'

describe Sandwich do

  before(:all) do
    @user = User.first || create(:user)
    @order = Order.create(user_id: @user.id)
    @sourdough = Container.create(name: 'sourdough')
    @wheat = Container.create(name: 'whole wheat')
    @turkey = Ingredient.create(name: 'turkey')
  end

  let(:sourdough) { Container.first  }
  let(:wheat)     { Container.last   }
  let(:turkey)    { Ingredient.first }
  let(:order)     { Order.first      }

  it "requires 1 container" do
    subject.valid?.should be(false)
    subject.container = wheat
    subject.order_id = order.id
    subject.valid?.should be(true)
    subject.containers << sourdough
    subject.valid?.should be(false)
  end

  it "does not allow duplicate ingredients" do
    subject.container = wheat
    subject.order_id = order.id
    subject.ingredients << turkey
    subject.ingredients << turkey
    subject.ingredients.length.should be(2)
    subject.save.should be(true)
    subject.ingredients.length.should be(1)
  end

  it "can be copied" do
    subject.container = wheat
    subject.order_id = order.id
    subject.ingredients << turkey
    subject.save.should be(true)
    sandwich = Sandwich.copy(subject.id)
    sandwich.order_id.should be(nil)
    sandwich.ingredients.should eq(subject.ingredients)
    sandwich.container.should eq(subject.container)
  end
end
