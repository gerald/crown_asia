class Role < ActiveRecord::Base

  has_many :role_users
  has_many :users, :through => :role_users
  
  validates :name, :presence => true
  
  serialize :permissions
  
  def permission_for(subject, action)
    return nil if self.permissions.nil? || self.permissions[subject.underscore].nil? || self.permissions[subject.underscore][action].nil?
    self.permissions[subject.underscore][action]
  end

end
