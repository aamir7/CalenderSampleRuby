#!/usr/bin/ruby
require "date"
require 'singleton'
require_relative "event_controller.rb"

class CalenderController
	include Singleton

	def display_calender
		print "Enter a Date in format [yyyy-mm-dd] OR just enter with nothing!\n"
		date = Time.now

		loop do
			input = gets.chomp

			if(input.empty? || input =~ /....-..-../)
				begin
					date = Date.parse(input) unless input.empty?
					break
				rescue Exception => e
					print "Invalid Date. Enter again!\n"
				end
			else
				print "Wrong format. Enter again!\n"
			end
		end
		display_calender_for_time(date)
	end

	def display_calender_for_time(time)
		given_day = time.day
		year = time.year
		month = time.month

		date = Date.parse([year, month, "01"].join("-"))
		wday = date.wday

		puts "\t\t    #{Date::MONTHNAMES[month]} #{year}    \t\t"

		0.upto(6).each do |day|
			print Date::ABBR_DAYNAMES[day], "\t"
			puts if day == 6 #line break
		end

		0.upto(6).cycle do |day|
			if day < wday # condition to reach proper day in first row
				print "\t"
				next
			else
				wday = -1 # to avoid above condition 

				print date.day == given_day ? "[#{given_day}]\t" : "#{date.day}\t"
					
				puts if day == 6 #line break
				date = date.next
					
				if date.month != month
					puts "\nNote: Date enclosed by [] means given date or today if not given.\n"
					break
				end
			end
		end
	end
end

