require 'spec_helper'

RSpec.describe User, :type => :model do
    
    it 'is invalid without a name' do 
        user = User.new(name: nil)
        expect(user).to_not be_valid
    end
    it 'is invalid without a email' do
        user = User.new(email: nil)
        expect(user).to_not be_valid
    end
    it 'is invalid without an password' do
        user = User.new(password: nil)
        expect(user).to_not be_valid
    end
end