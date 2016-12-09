class User < ActiveRecord::Base
  belongs_to :organization

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  class Role
    Member  			= 1
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

  def fullname
    "#{first_name} #{last_name}".titleize
  end
end
