require_relative '../lib/todo_list'
require_relative '../lib/todo_item'
require 'stringio'

describe ToDoList do
	before do
		@output = StringIO.new
		@mylist = ToDoList.new
		@wash_dishes = "wash the dishes"
		@trash = "take out the trash"
	end
	
	it "starts with a list of 0" do
		@mylist.size.should be 0
	end

	it "ititializes to empty" do
		@mylist.should be_empty
	end

	it "does not add a todo composed of only whitespace" do
		@mylist.add @wash_dishes
		@mylist.add ""
		@mylist.add "   "
		@mylist.size.should == 1
	end

	context "with one todo added" do
		before do
			@mylist.add(@wash_dishes)
		end
		it "has a size of 1" do
			@mylist.size.should be 1
		end

		it "reports that it is no longer empty" do
			@mylist.should_not be_empty
		end
	end

	context "with two todos added" do
		it "has a size of 2" do
			@mylist.add(@wash_dishes)
			@mylist.add(@trash)
			@mylist.size.should be 2
		end
	end
	context "with a populated list" do
		before do
			@mylist.add "Wash the dog"
			@mylist.add "Clean the table"
			@mylist.add "Clean bathroom"
		end

		it "lists the current todo items" do
			@mylist.show_todos(@output)
			@output.seek(0)
			@output.read.should match /1\. Wash the dog/
		end

		it "lets todos be selected by index" do
			@output.print @mylist.select(2)
			@output.seek 0
			@output.read.should == "Clean the table"
		end

		it "tracks items that are done" do
			@mylist.select(2).do
			@mylist.show_done(@output)
			@output.seek 0
			@output.read.should == "Clean the table\n"
		end

		it "allows done items to be purged" do
			@mylist.select(2).do
			@mylist.purge_done
			@mylist.show_done(@output)
			@output.seek 0
			@output.read.should == ""
		end

		it "saves and loads todo lists"
	end
end