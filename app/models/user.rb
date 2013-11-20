class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable#, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :role_ids
  
  validates :first_name, :last_name, :username, :presence => true
  
  validates :email, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/}, :allow_nil => true, :allow_blank => true
  validates :email, :uniqueness => true, :allow_nil => true, :allow_blank => true
  
  validates :password, :confirmation => true
  
  validates :username, :uniqueness => true
  
  has_many :role_users
  has_many :roles, :through => :role_users
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
  
  def has_role?(role_name)
    self.roles.count(:conditions => ["code = ?", role_name]) > 0
  end
  
  def self.current
    Thread.current[:user] || nil
  end

  def self.current= u
    Thread.current[:user] = u
  end
end
