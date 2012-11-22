class ToDoItem

	def initialize(desc)
		@desc = desc
	end

	def to_s
		return @desc
	end

	def do(parent_list)
		parent_list.mark_done(self)
	end
end