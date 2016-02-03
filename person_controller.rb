#!/usr/bin/ruby
require "singleton"
require_relative "person.rb"

class PersonController
	include Singleton

	def persons_list_empty?
		 @persons_list.empty?
	end
	
	def add_person
		person_name = ""

		loop do
			print "Enter person name!\n"
			person_name = gets
			person_name.chomp!

			if(person_name !~ /\w+$/)
				print "Invalid name!\n"
			elsif get_persons_for_name(person_name).any?
				print "Name already exist. Take a new name!\n"
			else
				break
			end
		end

		print "Enter person email!\n"
		person_email = gets
		person_email.chomp!

		@persons_list << Person.new(person_name, person_email)
			
		print "Person added successfully!\n"
	end

	def display_persons
		print "\n--------- [Persons] ----------\n"
		if(@persons_list.empty?)
			print "No person added yet!!!\n"
		else
			@persons_list.each {|person| print person.to_s}
		end
		print "--------- --------- ----------\n"
	end

	def get_persons_for_name(name)
		persons_list = @persons_list.select {|person| person.person_name == name}
		persons_list
	end

	private
		def initialize
			@persons_list = []
		end
end