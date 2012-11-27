require 'singleton'
require_relative 'todo_list'

class ToDoApp
	include Singleton

	attr_reader :file

	def start (params=ARGV, dest = STDOUT)
		check_params(params,dest)
		@file = params.shift
		@list = ToDoList.new @file
		@list.load if File.exist? @file+".save"
		@status = :menu
		app_loop()
	end

	def check_params(params, dest)
		unless params.size == 1
		  puts "Wrong number of arguments."
		  puts "Usage: ruby todo.rb list_name\n"
		  exit
		end
	end

	def app_loop
		while @status != :quit
			case @input
			when "q","Q"
				@status = :quit
			when "a", "A"
				add_item
			when "d", "D"
				mark_done
			when "p", "P"
				purge_done
			else 
				main_menu
			end
		end
	end

	def main_menu
		@list.show_all
		puts @error
		@error = nil
		puts "[Commands: q=quit, a=add, d=mark done, p=purge done items]"
		@input = $stdin.gets.chomp
	end

	def add_item
		@input.clear
		puts "Description (leave blank to cancel):"
		desc = $stdin.gets.chomp
		@list.add desc
		@error = "(Added: #{desc})"
	end

	def mark_done
		@input.clear
		puts "Which number?"
		selection = $stdin.gets.chomp
		check_selection(selection)
	end

	def check_selection(selection)
		if selection !~ /^\d+$/
			@error = "[Invalid selection] Just the number, please."
			return
		elsif selection.to_i == 0 || selection.to_i > @list.size
			@error = "[Invalid selection] No todo with that number."
			return
		end
		
		index = selection.to_i
		@error = "(Item completed: #{@list.select(index)})"
		@list.select(index).do
	end

	def purge_done
		@input.clear
		puts "Are you sure?(y/n)"
		answer = $stdin.gets.chomp
		case answer
		when "y", "Y"
			@list.purge_done
			@error = "(Done items purged)"
		else
			@error = "(purge cancelled)"
		end
	end

end


myapp = ToDoApp.instance

myapp.start# ["test"]