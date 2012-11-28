
module MMToDo
	class ToDoItem

		def initialize(desc, parent)
			@description = desc
			@parent_list = parent
		end

		def to_s
			return @description
		end

		def do 
			@parent_list.mark_done(self)
		end
	end
end