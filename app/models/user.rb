class User < ActiveRecord::Base
  has_secure_password

  # get modules to help with some functionality
  include CreameryHelpers::Validations

  # Relationships
  belongs_to :employee

  # Validations
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, :with => /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, :message => "is not a valid format"
  validate :employee_is_active_in_system
  
  ROLES = [['Employee', 'employee', :employee],['Manager', 'manager', :manager],['Administrator', 'admin', :admin]]

  def role?(authorized_role)
     return false if self.employee.role.nil?
     self.employee.role.to_sym == authorized_role
  end


  private
  def self.authenticate(email,password)
      find_by_email(email).try(:authenticate, password)
  end

  def employee_is_active_in_system
    is_active_in_system(:employee)
  end


end
