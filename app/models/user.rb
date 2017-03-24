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
  has_many :userboards
  has_many :tasks, foreign_key: :assigned_to_id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ActionController::Base.helpers.asset_path('default_person.png')
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
  after_create :create_default_userboards
  
  scope :not_organization_administrator, -> { where.not(role_id: 5) }
  default_scope  { where(active: true) }
  scope :this_organization, -> (organization_id) { where(organization_id: organization_id)}
  
  ROLES = {
    member: {id: 1, name: 'Member'},
    department_head: {id: 2, name: 'Department Head'},
    division_head: {id: 3, name: 'Division Head'},
    organization_head: {id: 4, name: 'Organization Head'},
    organization_administrator: {id: 5, name: 'Organization Administrator'}
  }

  FILTER_MEMBERS = {
    member: {id: 1, name: 'Specific Member'},
    team: {id: 2, name: 'Members of a Team'},
    department: {id: 3, name: 'Members of a Department'},
    division: {id: 4, name: 'Members of a Division'},
    organization: {id: 5, name: 'Members of Organization'}
  }
  
  class << self
   def current_user=(user)
     Thread.current[:current_user] = user
   end

   def current_user
     Thread.current[:current_user]
   end
  end
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

  private

  def create_default_userboards
    user = self
    type_t = user.userboards.build(name: "Today", userboard_type: "T", color: "C0ED92", status: "A")
    type_o = user.userboards.build(name: "Today", userboard_type: "O", color: "C0ED92", status: "A")  
    Userboard.transaction do
      type_t.save
      type_o.save
    end
  end
end
