require 'spec_helper'

    module Matchers
      class BeValid  #:nodoc:

        def matches?(model)
          @model = model
          @model.valid?
        end

        def failure_message
          "#{@model.class} expected to be valid but had errors:\n  #{@model.errors.full_messages.join("\n  ")}"
        end

        def negative_failure_message
          "#{@model.class} expected to have errors, but it did not"
        end

        def description
          "be valid"
        end

      end

      def be_valid
        BeValid.new
      end
    end

describe Amazon do
  include Matchers

  before do
    @valid_amazon = Amazon.new(:email => "blah@blah.com", :full_name => "Jane Blah", :country => "United States", :phone_number => "999-999-9999")
    @valid_amazon.address = Address.new(:line1 => "Address", :city => "somewhere", :zip => "123456", :state => "somestate")
    @valid_amazon.should be_valid
  end

  it "is a subscribable" do
    @valid_amazon.subscription.should be_nil
  end

  it "requires email" do
    @valid_amazon.email = ""
    @valid_amazon.should_not be_valid
  end

  it "requires full_name" do
    @valid_amazon.full_name = ""
    @valid_amazon.should_not be_valid
  end

  it "requires country" do
    @valid_amazon.country = ""
    @valid_amazon.should_not be_valid
  end

  it "requires phone_number" do
    @valid_amazon.phone_number = nil
    @valid_amazon.should_not be_valid
  end

  it "email should have valid format" do
    @valid_amazon.email = "**@blah.123"
    @valid_amazon.should_not be_valid
  end

end