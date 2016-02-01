#!/usr/bin/ruby
require "singleton"

class PersonStatus
	ATTENDING = 0
	NOT_ATTENDING = 1
	MAY_BE = 2
end

class Person

	attr_reader :person_name, :person_email

	def initialize(person_id, person_name, person_email)
		@person_id = person_id
		@person_name = person_name
		@person_email = person_email
	end

	def to_s
		print "Person [Id: #{@person_id}, Name: #{@person_name}, Email: #{@person_email}]\n"
	end
end

class EventPerson

	attr_reader :event_id
	attr_accessor :person_name, :person_email

	def initialize(event_id, person_name, person_email, status)
		@event_id = event_id
		@person_name = person_name
		@person_email = person_email
		@attending_status = status
	end

	def to_s
		print "Person [Event Id: #{@event_id}, Name: #{@person_name}, Email: #{@person_email}, Status: #{@attending_status}]\n"
	end
end
