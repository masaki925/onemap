require 'spec_helper'

describe "spots/show" do
  before(:each) do
    @spot = assign(:spot, stub_model(Spot,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
