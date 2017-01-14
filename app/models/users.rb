class User < ActiveRecord::Base
    validates :name, :email, :password, :presence => true
    validates :email, uniqueness: true
    has_secure_password
     # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end