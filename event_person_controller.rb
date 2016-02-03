#!/usr/bin/ruby
require "singleton"
require_relative "event_person.rb"
require_relative "person_controller.rb"

class EventPersonController
	include Singleton

	def add_existing_person_to_event(event_id)
		person = ""
		loop do
			puts "Enter person name!"
			person_name = gets.chomp

			persons = PersonController.instance.get_persons_for_name(person_name)

			if persons.empty?
				print "Name does not exist!!!"
			elsif get_persons_for_name_and_event(person_name, event_id).any?
				print "Name already added in this event!!!"
			else
				person = persons[0]
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

	def add_new_person_to_event(event_id)
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

	private
		def initialize
			@event_persons_list = []
		end

		def get_persons_for_name_and_event(name, event_id)
			persons_list = @event_persons_list.select {|person| person.person_name == name && person.event_id == event_id}
			persons_list
		end
end