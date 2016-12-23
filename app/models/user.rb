class User < ActiveRecord::Base
  belongs_to :organization
  belongs_to :division
  belongs_to :department
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = {
    member: {id: 1, name: 'Member'},
    department_head: { id: 2, name: 'Department Head'}
  }

  class Role
    Member  			 = 1
    Department_Head		= 2
    Division_Head 		= 3
    Organization_Head   = 4
    Organization_Administrator 		= 5
    DISPLAY_NAMES  =  {
      Member =>  'Member',
      Department_Head =>  'Department Head',
      Division_Head =>  'Division Head',
      Organization_Head =>  'Organization Head',
      Organization_Administrator => 'Organization Administrator'
    }
  end

  scope :organization_administrator!, -> { where(role_id: [User::Role::Member, User::Role::Department_Head, User::Role::Division_Head, User::Role::Organization_Head]) }
  scope :member!, -> { where(role_id: [User::Role::Organization_Administrator, User::Role::Department_Head, User::Role::Division_Head, User::Role::Organization_Head]) }
  scope :department_head!, -> { where(role_id: [User::Role::Member, User::Role::Organization_Administrator, User::Role::Division_Head, User::Role::Organization_Head]) }
  scope :division_head!, -> { where(role_id: [User::Role::Member, User::Role::Department_Head, User::Role::Organization_Administrator, User::Role::Organization_Head]) }
  scope :organization_head!, -> { where(role_id: [User::Role::Member, User::Role::Department_Head, User::Role::Division_Head, User::Role::Organization_Administrator]) }

  def fullname
    "#{first_name} #{last_name}".titleize
  end

  def organization_name
    "#{self.organization.name.titleize}"
  end
  
  def member?
    self.role_id == User::Role::Member
  end

  def department_head?
    self.role_id == User::Role::Department_Head
  end

  def organization_head?
    self.role_id == User::Role::Organization_Head
  end

  def organization_administrator?
    self.role_id == User::Role::Organization_Administrator
  end

  def division_head?
    self.role_id == User::Role::Division_Head
  end
end
