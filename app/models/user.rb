class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  
  validates :first_name, :last_name, :username, :presence => true
  
  has_many :role_users
  has_many :roles, :through => :role_users
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
  
  def has_role?(role_name)
    self.roles.count(:conditions => ["name = ?", role_name]) > 0
  end
end
