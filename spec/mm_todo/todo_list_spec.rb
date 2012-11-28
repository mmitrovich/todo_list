require 'mm_todo/todo_list'
require 'mm_todo/todo_item'
require 'stringio'


module MMToDo
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


		end
		context "saving / loading" do 
			before do
				@savetest = ToDoList.new("savetest")
				@list1 = ToDoList.new("list1")
				@todo1 = "go to work"
				@todo2 = "pay bills"
				@todo3 = "feed dog"
			end

			after do
				files = ["savetest.save", "list1.save", "testlist.save", "unnamed.save"]
				files.each do |file|
					#File.delete file if File.exist? file
					File.delete file if File.exist? File.join(File.expand_path("../../bin/", File.dirname(__FILE__)), file+'.save')
				end
			end

			it "initializes a save file" do
				@savetest.save
				File.exist?(File.join(File.expand_path("../../bin/", File.dirname(__FILE__)),"savetest.save")).should be_true
				File.delete File.join(File.expand_path("../../bin/", File.dirname(__FILE__)),"savetest.save")
			end

			it "loads saved lists" do@list1.add @todo1 
				@list1.add @todo2 
				@list1.add @todo3
				@list1.select(2).do
				@list1.save

				list2 = ToDoList.new("list1")
				list2.load
				list2.show_done(@output)
				@output.rewind
				@output.read.should == "pay bills\n"
			end
			it "updates the save file when adding new todos" do
				@savetest.add @todo1

				newlist = ToDoList.new("savetest")
				newlist.load
				newlist.show_todos(@output)
				@output.rewind
				@output.read.should == "1. go to work\n"
			end

			it "updates the save file when marking items done" do
				@savetest.add @todo1
				@savetest.add @todo2

				@savetest.select(2).do

				newlist = ToDoList.new("savetest")
				newlist.load
				newlist.show_done(@output)
				@output.rewind
				@output.read.should == "pay bills\n"
			end

			it "updates the save file when purging done items" do
				@savetest.add @todo1
				@savetest.add @todo2

				@savetest.select(2).do
				@savetest.purge_done

				newlist = ToDoList.new("savetest")
				newlist.load
				newlist.show_done(@output)
				@output.rewind
				@output.read.should == ""
			end
		end # save/load context
	end
end