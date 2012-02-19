require 'spec_helper'

describe StaticPagesController do

  describe "GET 'error'" do
    it "should be successful" do
      get 'error'
      response.should be_success
    end
  end

end
