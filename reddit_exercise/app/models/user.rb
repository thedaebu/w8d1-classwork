class User < ApplicationRecord
    validates :username, :password_digest, :session_token, presence: true
    validates :username, uniqueness: true
    validates :password, length: {minimum: 6}, allow_nil: true

    attr_reader :password
    
    before_validation :ensure_session_token

    has_many :subs,
        foreign_key: :moderator_id,
        class_name: :Sub

    has_many :posts,
        foreign_key: :author_id,
        class_name: :Post


    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        if @user && @user.is_password?(password)
            @user
        else
            nil
        end
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(password_digest).is_password?(password)
    end

    def generate_session_token!
        SecureRandom::base64
    end

    def reset_session_token!
        self.session_token = generate_session_token!
        self.save!
        self.session_token

    end

    private
    def ensure_session_token
        self.session_token ||= generate_session_token!
    end
end
