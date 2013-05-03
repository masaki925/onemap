require 'spec_helper'

describe "plandays/index" do
  before(:each) do
    assign(:plandays, [
      stub_model(Planday,
        :plan => nil,
        :day => 1
      ),
      stub_model(Planday,
        :plan => nil,
        :day => 1
      )
    ])
  end

  it "renders a list of plandays" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
