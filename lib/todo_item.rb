class ToDoItem

	def initialize(desc, parent)
		@desc = desc
		@parent_list = parent
	end

	def to_s
		return @desc
	end

	def do 
		@parent_list.mark_done(self)
	end
end