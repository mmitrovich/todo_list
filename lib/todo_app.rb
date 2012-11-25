require 'singleton'
require_relative 'todo_list'

class ToDoApp
	include Singleton

	attr_reader :file

	def start (params=ARGV, dest = STDOUT)
		check_params(params,dest)
		@file = params
		@list = ToDoList.new
		
	end

	def check_params(params, dest)
		raise if (params.size != 1)
		rescue
			dest.puts "ToDoApp: Wrong number of parameters (#{params.size})"
			dest.puts "Usage: ruby todo_app <list_name>"
	end
end


myapp = ToDoApp.instance

myapp.start(["test"])