require 'spec_helper'
require File.expand_path("../../lib/user_safe.rb", File.dirname(__FILE__))
describe UserSafe do

  it "can generate a public key and encrypted private key" do
    pair = UserSafe.generate_pair("password")
    pair.size.should == 2
  end

  it "can encrypt data" do
    public_key, _ = UserSafe.generate_pair("password")
    result = UserSafe.encrypt("some data", public_key)
    result.should_not == "some data"
  end

  def rand_word(size = 10)
    word = ""
    size.times { word << ('A'..'z').to_a.sample }
    word
  end

  it "can decrypt the encrypted data" do
    password = rand_word(20)
    data = rand_word(243)
    public_key, encrypted_private_key = UserSafe.generate_pair(password)

    encrypted_data = UserSafe.encrypt(data, public_key)
    puts "size: #{encrypted_data.size}"

    UserSafe.decrypt(encrypted_data, public_key, encrypted_private_key, password).should == data 
  end

end
