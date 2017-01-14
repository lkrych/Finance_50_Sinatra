require 'support/factory_girl'
require 'spec_helper'

# This will guess the User class
FactoryGirl.define do
    factory :user do
        name "John"
        email  "John@valid.com"
        password_digest  User.digest('foobar')
    end
end