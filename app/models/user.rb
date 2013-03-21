# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  password   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#

class User < ActiveRecord::Base
  has_many :posts

  attr_accessible :email, :password, :name

  before_save :encrypt_password
  
  validates_presence_of :password, :email, :name
  validates_uniqueness_of :email

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of :email, :with => email_regex

  before_save :encrypt_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == Digest::MD5.hexdigest(password)
      user
    else
      nil
    end
  end

  private 

 		def encrypt_password 
 			self.password = encrypt(password)
 		end

 		def encrypt(string) 
 			Digest::MD5.hexdigest(string)
 		end

end
