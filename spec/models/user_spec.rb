require 'spec_helper'


describe User do

  it "should create a new instance given compatible attribute values" do

    @valid_attributes = {
      :name => "aman garg",
      :email => "aman199002@gmail.com",
      :password => 'test123',
      :password_confirmation => 'test123'
     }
   user = User.create(@valid_attributes)
   user.should be_persisted
  end
 
  it "should not create a new instance given incompatible attribute values" do

    @invalid_attributes = {
      :name => "aman garg",
      :email => "dfdsgfgfdgfdgfdd",
      :password => 'test123',
      :password_confirmation => ''
    }
    user = User.create(@invalid_attributes)
    user.should_not(be_valid)
  end
end