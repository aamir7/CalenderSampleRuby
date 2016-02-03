#!/usr/bin/ruby

class Person
	@@person_count = 0
	attr_reader :person_name, :person_email

	def initialize(person_name, person_email)
		@person_id = @@person_count += 1
		@person_name = person_name
		@person_email = person_email
	end

	def to_s
		print "Person [Id: #{@person_id}, Name: #{@person_name}, Email: #{@person_email}]\n"
	end
end
