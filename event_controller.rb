#!/usr/bin/ruby
require 'singleton'
require_relative "event.rb"
require_relative "person_controller.rb"
require_relative "event_person_controller.rb"

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
		event = Event.new

		loop do
			puts "Enter event title!"
			title = gets.chomp

			if(title.empty?)
				puts "Title can not be empty!!!"
			elsif(get_events_for_title(title).any?)
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
			persons_list_empty = PersonController.instance.persons_list_empty?
			puts "Enter accordingly!"
			puts "1: Existing person!" unless persons_list_empty
			puts "2: Other person!"
			puts "Any other key for continue!"

			input = gets.chomp
			
			if input == "1" && !persons_list_empty
				EventPersonController.instance.add_existing_person_to_event(event.event_id)
			elsif input == "2"
				EventPersonController.instance.add_new_person_to_event(event.event_id)
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

			events = get_events_for_title(title)
			if(events.any?)
				events.each do |event|
					@events_list.map! do |e|
						e.event_status = EventStatus::CANCELLED if e.event_id == event.event_id
						puts "Event cancelled!!!"
						e #return itself
					end
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

	private
		def initialize
			@events_list = []
		end

		def get_events_for_title(title)
			events_list = @events_list.select {|event| event.event_title == title}
			events_list
		end
end
