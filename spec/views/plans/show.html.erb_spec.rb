require 'spec_helper'

describe "plans/show" do
  before(:each) do
    @plan = assign(:plan, stub_model(Plan,
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
  end
end
