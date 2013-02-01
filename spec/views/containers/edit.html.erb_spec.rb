require 'spec_helper'

describe "containers/edit" do
  before(:each) do
    @container = assign(:container, stub_model(Container,
      :name => "MyString"
    ))
  end

  it "renders the edit container form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => containers_path(@container), :method => "post" do
      assert_select "input#container_name", :name => "container[name]"
    end
  end
end
