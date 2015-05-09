class Control
	include Mongoid::Document

	validates :level, presence: true
	validates :period, presence: true
	validates :day, presence: true
	validates :level, :numericality => { :greater_than => 24, :less_than_or_equal_to => 600 }
	
	belongs_to :user

	field :level, type: Integer
	field :period, type: String
	field :day, type: DateTime

	scope :by_day, ->(day) { where("day like ?", "#{day}%") }

	@@periods= [
		'pre-breakfast',
		'post-breakfast',
		'pre-lunch',
		'post-lunch',
		'afternoon',
		'pre-dinner',
		'post-dinner'
	]

	def self.periods
		@@periods
	end

	def get_day
		calendar_day = DateTime.new(day.year, day.month, day.day)
		calendar_day
	end

	scope :order_by_date, -> (user_id) do
		where(user_id: user_id)
		.sort_by { |control| [control.day]}
		.sort { |a,b| a[0] <=> b[0] }
		.reverse
	end


	

	def self.graphic_data_for_a_day(user_id, day)
		controls= Control.compare_day(day, user_id)
		controls_array=	controls.map do |control|
				[control.day.strftime("%I:%M%p").to_time.utc.to_i * 1000, control.level]

		end
		controls_array = controls_array.sort do |a,b| a[0] <=> b[0] end
		graphic_data = {  name: "day",
						  data: controls_array
										}
    	graphic_data
	end

	def self.graphic_data_for_all_days(user_id)
		graphic_data = []
		Control.list_days_controls(user_id).each do |day|
			graphic_data.push(Control.graphic_data_for_a_day(user_id, day.to_s,))
		end
		graphic_data
	end

	def self.levels_average(user_id)
		levels_average = 0
		if Control.count > 0
			levels = Control.where(user_id: user_id).map { |control| control.level } 
			levels_average = levels.reduce(:+).to_f / levels.size 
		 end
		levels_average.round(2)
	end

	def self.controls_by_day_average(user_id)
		user = User.where(user_id: user_id)
		puts "I get until here"
		p Control.all.where(user_id: user_id)
		return 0.0 if Control.all.where(user_id: user_id).count == 0
		first_user_control_day = Control.first_user_control_day(user_id)
		difference_days = (DateTime.now.to_date - first_user_control_day.to_date).to_i
		difference_days = 1 if difference_days == 0
		controls = Control.where(user_id: user_id)
		controls_average = (controls.size / difference_days.to_f)
		controls_average.round(2)
	end	
	
	def self.last_control_level(user_id)
		controls = Control.where(user_id: user_id).sort_by { |control| control.day }
		last_control = controls.last.level if controls.last
		last_control
	end
	
	private
	
	def self.compare_day(day, user_id) 
		where(user_id: user_id).select do |control|
			 control.day.to_date == day.to_date
		end
	end

	def self.list_days_controls(user_id)
		days=[]
		where(user_id: user_id).each do |control|
			unless days.include?(control.day.to_date)
				days.push(control.day.to_date)
			end
			end
		days
	end
    
   def self.first_user_control_day(user_id)
   	controls = Control.where(user_id: user_id)
		controls = controls.sort_by { |control| control.day }
		first_user_control_day = controls[0].day
		first_user_control_day
   end
end


