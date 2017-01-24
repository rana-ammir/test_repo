class User < ActiveRecord::Base
  belongs_to :organization
  belongs_to :division
  belongs_to :department
  
  has_many :team_users
  has_many :teams, -> { uniq }, through: :team_users
  has_many :user_objectives
  has_many :objectives, through: :user_objectives
  has_many :user_strategies
  has_many :strategies, through: :user_strategies
  has_many :user_tactics
  has_many :tactics, through: :user_tactics
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = {
    member: {id: 1, name: 'Member'},
    department_head: {id: 2, name: 'Department Head'},
    division_head: {id: 3, name: 'Division Head'},
    organization_head: {id: 4, name: 'Organization Head'},
    organization_administrator: {id: 5, name: 'Organization Administrator'}
  }

  scope :not_organization_administrator, -> { where.not(role_id: 5) }
  default_scope  { where(active: true) }

  def fullname
    "#{first_name} #{last_name}".titleize
  end

  def lname_fname
    "#{last_name} #{first_name}".titleize
  end

  def organization_name
    "#{self.organization.name.titleize}"
  end
  
  def organization_divisions
    self.organization.divisions  
  end

  def organization_plans
    self.organization.plans  
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

  class Role
    Member         = 1
    Department_Head   = 2
    Division_Head     = 3
    Organization_Head   = 4
    Organization_Administrator    = 5
    DISPLAY_NAMES  =  {
      Member =>  'Member',
      Department_Head =>  'Department Head',
      Division_Head =>  'Division Head',
      Organization_Head =>  'Organization Head',
      Organization_Administrator => 'Organization Administrator'
    }
  end
end
