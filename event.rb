#!/usr/bin/ruby
require 'singleton'
require_relative "person.rb"

class EventStatus
	CANCELLED = 0
	CONFIRMED = 1
	TENTATIVE = 2
end

class Event
	
	attr_accessor :event_id, :event_title, :event_description, :event_location
	attr_accessor :event_organizer, :event_status, :event_start_time, :event_end_time

	def initialize
		@event_id = @event_title = @event_location = ""
		@event_end_time = @event_start_time = @event_description = ""
		@event_status = EventStatus::TENTATIVE
	end

	def to_s
		puts "Event [Event title: #{@event_title}, Event description #{@event_description}, Event status: #{@event_status}]"
		puts " --------  Attending persons -------- "
		PersonController.instance.display_event_persons(@event_id)
		puts "--------- --------- ----------"
	end
end
