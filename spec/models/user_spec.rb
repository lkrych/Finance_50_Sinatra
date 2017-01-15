require 'spec_helper'
require 'support/factory_girl'
require 'pry'

RSpec.describe User, :type => :model do
    
    it 'is invalid without a name' do 
        user = User.new(name: nil)
        expect(user).to_not be_valid
    end
    
    it 'is invalid without a email' do
        user = User.new(email: nil)
        expect(user).to_not be_valid
    end
    
    it 'is invalid without a password' do
        user = User.new(password: nil)
        expect(user).to_not be_valid
    end
    
    it 'should not allow multiple people to sign up with the same e-mail' do
        User.all.delete_all() #clear db
        FactoryGirl.create(:user)
        user = build(:user, name: 'John', email: 'John@valid.com', password: 'foobar')
        expect(user).to be_invalid
    end
end