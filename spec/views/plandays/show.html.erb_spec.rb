require 'spec_helper'

describe "plandays/show" do
  before(:each) do
    @planday = assign(:planday, stub_model(Planday,
      :plan => nil,
      :day => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/1/)
  end
end
