#!/usr/bin/ruby
require 'singleton'
require_relative "event.rb"
require_relative "person_controller.rb"

class EventController
	include Singleton
	
	def display_event
		print "\n--------- [Events] ----------\n"
		if(@events_list.empty?)
			print "No event added yet!!!\n"
		else
			@events_list.each {|event| print event.to_s}
		end
	end

	def add_event
		@event_id = @event_id + 1

		event = Event.new
		event.event_id = @event_id

		loop do
			puts "Enter event title!"
			title = gets.chomp

			if(title.empty?)
				puts "Title can not be empty!!!"
			elsif(check_event_exit(title).any?)
				puts "Event for title already exist!!!"
			else
				event.event_title = title
				break
			end
		end

		puts "Enter event description!"
		event.event_description = gets.chomp

		puts "Enter event location!"
		event.event_location = gets.chomp

		puts "Enter event organizer!"
		event.event_organizer = gets.chomp 

		puts "Enter event start time!"
		event.event_start_time = gets.chomp

		puts "Enter event end time!"
		event.event_end_time = gets.chomp 

		loop do
			persons_exist = PersonController.instance.persons_exist?
			puts "Enter accordingly!"
			puts "1: Existing person!" if persons_exist
			puts "2: Other person!"
			puts "Any other key for continue!"

			input = gets.chomp
			
			if input == "1" && persons_exist
				PersonController.instance.addExistingPersonToEvent(@event_id)
			elsif input == "2"
				PersonController.instance.addNewPersonToEvent(@event_id)
			else
				break
			end
		end

		puts "Enter event status: (1 for confirmed, any key for tentaive)"
		status = gets.chomp
		event.event_status = status == "1" ? (EventStatus::CONFIRMED) : (EventStatus::TENTATIVE)

		@events_list << event
	end

	def cancel_event
		loop do
			puts "Enter event title!"
			title = gets.chomp

			events = check_event(title)
			if(events.any?)
				events.each do |event|
					@events_list.map! do |e|
						e.event_status = EventStatus::CANCELLED if e.event_id == event.event_id
						e #return itself
					end
					puts "Event is cancelled!!!"
				end
				break
			else
				puts "Event for given title not exist!"
				puts "Enter 1 for retry or any key to skip!"

				input = gets.chomp
				if(input != "1") 
					break
				end
			end
		end
	end

	def check_event(title)
		elem_arr = @events_list.select {|event| event.event_title == title}
		elem_arr
	end

	private
		def initialize
			@event_id = 0
			@events_list = []
		end

		def check_event_exit(title)
			elem_arr = @events_list.select {|event| event.event_title == title}
			elem_arr
		end
end
