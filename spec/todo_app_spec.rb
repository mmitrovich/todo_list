require_relative '../lib/todo_app'
require 'stringio'

describe ToDoApp do
	before do
		@output = StringIO.new
		@myapp = ToDoApp.instance
	end

	it "displays some help text if no commandline parameter given" do
		@myapp.start([], @output)
		@output.rewind
		@output.read.should match /ToDoApp: Wrong number of parameters/
	end

	it "displays some help text if more than 1 commandline parameter given" do
		@myapp.start(["item1", "item2"], @output)
		@output.rewind
		@output.read.should match /ToDoApp: Wrong number of parameters/
	end
	


end