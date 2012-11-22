require_relative 'todo_item'

class ToDoList


	def initialize
		@list = []
		@done = []
	end

	def add(todo)
		@list.push ToDoItem.new(todo, self)
	end

	def size
		return @list.size
	end

	def empty?
		return @list.empty?
	end

	def show_todos(dest = STDOUT)
		@list.each_index {|index| dest.puts "#{index + 1}. #{@list[index]}"}
	end

	def show_done(dest = STDOUT)
		@done.each {|item| dest.puts item}
	end

	def select(index)
		return @list[index - 1]
	end

	def mark_done(item)
		@done.push item
		@list.delete item
	end
end


if __FILE__ == $0
mylist = ToDoList.new

mylist.add("feed the fish")

mylist.show_todos

end