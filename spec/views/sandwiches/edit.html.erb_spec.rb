require 'spec_helper'

describe "sandwiches/edit" do
  before(:each) do
    @sandwich = assign(:sandwich, stub_model(Sandwich))
  end

  it "renders the edit sandwich form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sandwiches_path(@sandwich), :method => "post" do
    end
  end
end if false
