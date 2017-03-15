class Task < ActiveRecord::Base
	belongs_to :tactic
	belongs_to :organization
	belongs_to :user, foreign_key: :assigned_to_id

	has_many :activities
	has_many :assets, as: :assetable, dependent: :destroy
	has_many :userboards
	acts_as_taggable_on :tags
		
	validates :task_type, :description, :status, :due_date, :requestor_id,
	  :assigned_to_id, :actual_hours, :completion_date, :progress, presence: true, if: :manual_task_entry_changed?, on: :create
	validates :task_type, :description, :status, :due_date, :requestor_id, :assigned_to_id, :progress, presence: true, if: :publish_task_changed?
	
	accepts_nested_attributes_for :assets, reject_if: :all_blank, allow_destroy: true
	
	after_update :update_tactic

	scope :find_task, -> (tactic_id) { where(tactic_id: tactic_id) }
	scope :filter_task, -> (status) { where(status: status) }
	scope :active_tasks, -> { where.not(status: "Completed") }

	def completion_date= date
		if date.present? && date.is_a?(String)
			self[:completion_date] = parse_date(date)
		elsif date.present? && date.is_a?(Date)
			self[:completion_date] = date
		else
			self[:completion_date] = nil
		end
	end

	def due_date= date
		if date.present? && date.is_a?(String)
			self[:due_date] = parse_date(date)
		elsif date.present? && date.is_a?(Date)
			self[:due_date] = date
		else
			self[:due_date] = nil
		end
	end
	
	def parse_date(date)
		Date.strptime(date, "%m/%d/%Y")
	end
	
	def manual_task_entry_changed?
		task_type == "Manual Entry"
	end
	
	def publish_task_changed?
		task_type == "SP"
	end
	
	def objective
		self.tactic.strategy.objective
	end
	
	def strategy
		self.tactic.strategy
	end

	def new_task?
		self.status == "New"
	end

	def strategic?
		self.task_type == "SP"	
	end
	
	private

	def update_tactic
		if self.tactic.present? && self.progress_changed?
			self.tactic.update_attributes(percent_of_strategy: self.progress)	
		end
	end
end
