require 'spec_helper'

describe StaticController do

  describe "GET 'favorite'" do
    it "returns http success" do
      get 'favorite'
      response.should be_success
    end
  end

  describe "GET 'spotsearch'" do
    it "returns http success" do
      get 'spotsearch'
      response.should be_success
    end
  end

end
