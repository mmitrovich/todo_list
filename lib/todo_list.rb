require_relative 'todo_item'

class ToDoList


	def initialize(save_file="unnamed")
		@list = []
		@done = []
		@save_file = save_file + '.save'
	end

	def save
		File.open(@save_file, 'w') {|f| f.write Marshal.dump([@list,@done]) }
	end

	def load
		@list,@done = Marshal.load(File.read(@save_file))
	end

	def add(todo = "")
		raise if todo =~ /^\s*$/
		@list.push ToDoItem.new(todo, self)
		save
		rescue
			puts "[Empty todo not added...]"
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
		save
	end

	def show_all(dest = STDOUT)
		puts "TODO:"
		puts "=========="
		show_todos
		puts "\n\nDone:"
		puts "=========="
		show_done
		puts "\n\n\n"
	end

	def purge_done
		@done = []
		save
	end
end


if __FILE__ == $0
mylist = ToDoList.new

mylist.add("feed the fish")
mylist.add("go shopping")
mylist.add("wash dishes")
mylist.add "   "

mylist.select(2).do

mylist.show_all

mylist.purge_done
mylist.show_all

File.open('mylist.save', 'w') {|f| f.write Marshal.dump(mylist) }

newlist = Marshal.load File.read('mylist.save')

puts "Newlist:"
newlist.show_all
end