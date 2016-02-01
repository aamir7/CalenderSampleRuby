#!/usr/bin/ruby
require "singleton"
require_relative "person.rb"

class PersonController
	include Singleton

	private
		def initialize() 
			@person_id = 0
			@persons_list = []
			@event_persons_list = []
		end

		def check_person_exit(name)
			elem_arr = @persons_list.select {|person| person.person_name == name}
			elem_arr
		end

		def check_person_added(name, event_id)
			elem_arr = @event_persons_list.select {|person| person.person_name == name && person.event_id == event_id}
			elem_arr
		end

	public
		def persons_exist?
			not @persons_list.empty?
		end
		def add_person()
			print "Enter person name!\n"

			while(true)
				person_name = gets
				person_name.chomp!

				if(person_name !~ /\w+$/)
					print "Enter valid name!\n"
				elsif check_person_exit(person_name).any?
					print "Name already exist. Take a new name!\n"
				else
					break
				end
			end

			print "Enter person email!\n"
			person_email = gets
			person_email.chomp!

			@person_id = @person_id + 1
			@persons_list << Person.new(@person_id, person_name, person_email)
			
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

		def addExistingPersonToEvent(event_id)
			person = ""
			loop do
				puts "Enter person name!"
				person_name = gets.chomp

				person = check_person_exit(person_name)

				if not person.any?
					print "Name does not exist!!!"
				elsif check_person_added(person_name, event_id).any?
					print "Name already added!!!"
				else
					person = person[0]
					break
				end

				print "\n(Enter 1 to retry or any key to skip)\n"
				input = gets.chomp

				if input != "1"
					return
				end
			end

			puts "Enter 1 for person 'attending' or any key for 'may be'!"
			status = gets.chomp

			status = status == "1" ? PersonStatus::ATTENDING : PersonStatus::MAY_BE
			event_person = EventPerson.new(event_id, person.person_name, person.person_email, status)

			@event_persons_list << event_person
		end

		def addNewPersonToEvent(event_id)
			email = ""
			loop do
				puts "Enter person email!"
				email = gets.chomp
				puts "#{email}"
				if(email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/)
					break
				else
					puts "Oooops! Invalid email!!!"
				end
			end

			puts "Enter 1 for person 'attending' or any key for 'may be'!"
			status = gets.chomp

			status = status == "1" ? PersonStatus::ATTENDING : PersonStatus::MAY_BE
			event_person = EventPerson.new(event_id, "", email, status)

			@event_persons_list << event_person
		end

		def display_event_persons(event_id)
			@event_persons_list.each do |person|
				if(person.event_id == event_id)
					puts "#{person.to_s}"
				end
			end
		end
end