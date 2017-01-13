helpers do
    def current_user(session_hash)
        return User.find_by_id(session_hash[:user_id])
    end
    
    def is_logged_in?(session_hash)
        return current_user.id == session_hash[:user_id]
    end
end