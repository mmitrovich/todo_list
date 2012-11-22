require_relative '../lib/todo_list'
require_relative '../lib/todo_item'

describe ToDoList do
	
	it "starts with a list of 0" do
		mylist = ToDoList.new
		mylist.size.should be 0
	end

	context "with one todo added" do
		it "has a size of 1" do
			mylist = ToDoList.new
			wash_dishes = ToDoItem.new
			mylist.add(wash_dishes)
			mylist.size.should be 1
		end
	end

	context "with two todos added" do
		it "has a size of 2"
	end
end