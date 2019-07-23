class User < ApplicationRecord

	
	has_and_belongs_to_many :animals
	validates :username, uniqueness: true
    has_secure_password
    

end
