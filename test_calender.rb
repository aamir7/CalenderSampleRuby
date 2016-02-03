#!/usr/bin/ruby
require_relative "event_controller.rb"
require_relative "person_controller.rb"
require_relative "calender_controller.rb"

class TestCalender

	def initialize
		@event_controller = EventController.instance
		@person_controller = PersonController.instance
		@calender_controller = CalenderController.instance
	end
	
	def main
		loop do
			print "\n----- ----- ----- ------\n" << "Please enter accordingly...\n"

			print "1: Add a person\n"
			print "2: Display all persons\n"
			print "3: Display calender\n"
			print "4: Add an event\n"
			print "5: Display events\n"
			print "6: Cancel an event\n"
			print "7: Exit\n"

			input = gets.chomp

			case input

			when "1"
				@person_controller.add_person
			when "2"
				@person_controller.display_persons
			when "3"
				@calender_controller.display_calender
			when "4"
				@event_controller.add_event
			when "5"
				@event_controller.display_event
			when "6"
				@event_controller.cancel_event
			when "7"
				break
			else
				print "\nEntered wrong option!!! [#{input}]\n"
			end
		end
	end
end