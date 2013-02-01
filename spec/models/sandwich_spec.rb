require 'spec_helper'

describe Sandwich do

  before(:all) do
    @sourdough = Container.create(name: 'sourdough')
    @wheat = Container.create(name: 'whole wheat')
    @turkey = Ingredient.create(name: 'turkey')
  end

  let(:sourdough) { Container.first  }
  let(:wheat)     { Container.last   }
  let(:turkey)    { Ingredient.first }

  it "requires 1 container" do
    subject.valid?.should be(false)
    subject.container = wheat
    subject.valid?.should be(true)
    subject.containers << sourdough
    subject.valid?.should be(false)
  end

  it "does not allow duplicate ingredients" do
    subject.container = wheat
    subject.ingredients << turkey
    subject.ingredients << turkey
    subject.ingredients.length.should be(2)
    subject.save.should be(true)
    subject.ingredients.length.should be(1)
  end
end
