class User < ApplicationRecord

	
	has_many :favorites
	validates :username, uniqueness: true
    has_secure_password
    

end
