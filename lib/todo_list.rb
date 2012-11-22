require_relative 'todo_item'

class ToDoList


	def initialize
		@list = []
	end

	def add(todo)
		@list.push ToDoItem.new(todo)
	end

	def size
		return @list.size
	end

	def empty?
		return @list.empty?
	end

	def show(dest = STDOUT)
		@list.each_index {|index| dest.puts "#{index + 1}. #{@list[index]}"}
	end

	def select(index)
		return @list[index - 1]
	end
end


if __FILE__ == $0
mylist = ToDoList.new

mylist.add("feed the fish")

mylist.show
end