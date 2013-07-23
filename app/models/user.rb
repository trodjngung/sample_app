# presence: true kiem tra ton tai cua string
# uniqueness: true kiem tra string da dc khai bao truoc chua
# uniqueness: { case_sensitive: false } kiem tra email co trung truoc chua va save email thanh chu thuong khi no duoc viet hoa 1 hay nhieu ky true

class User < ActiveRecord::Base

	before_save { self.email = email.downcase }

	validates :name, presence: true, length: { maximum: 50 }


	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:true, 
				format: { with: VALID_EMAIL_REGEX }, 
				uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 6 }
end
