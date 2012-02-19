require 'spec_helper'

describe StaticPagesController do

  describe "GET 'error'" do
    it "should be successful" do
      get 'error'
      response.should be_success
    end

    it "should have the right title" do
      get 'error'
      response.should have_selector("title",
                        :content => "NomAddress.com | Error")
     
    end
  end

end
