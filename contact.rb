require "./phone_number.rb"
require "./address.rb"

class Contact
	attr_writer :first_name, :middle_name, :last_name 
	attr_reader :phone_numbers, :addresses

	def initialize
		@phone_numbers = []
		@addresses = []
	end

	def add_phone_number(kind, number)
		phone_number = PhoneNumber.new	
		phone_number.kind = kind
		phone_number.number = number
		phone_numbers.push(phone_number)
	end

	def add_address(kind, street_1, street_2, city, state, postal_code)
		address = Address.new
		address.kind = kind
		address.street_1 = street_1
		address.street_2 = street_2
		address.city = city
		address.state = state
		address.postal_code = postal_code
		addresses.push(address)
	end
	
	def first_name
		@first_name
	end

	def middle_name
		@middle_name
	end

	def last_name
		@last_name
	end

	def first_last
		first_name + " " + last_name
	end

	def last_first
		last_first = last_name
		last_first += ", "
		last_first += first_name
		unless middle_name.nil?
			last_first += " "
			last_first += middle_name.slice(0, 1).upcase
			last_first += "."
		end
		last_first
	end

	def full_name
		full_name = first_name
		full_name += " "
		unless middle_name.nil?
			full_name += middle_name + " "
		end
		full_name += last_name
		full_name
	end

	def to_s(format = 'full_name')
		case format
		when 'full_name'
			full_name
		when 'last_first'
			last_first
		when 'first'
			first_name
		when 'last'
			last_name
		else
			last_first
		end				
	end

	def print_phone_numbers
		puts "------Phone Numbers------s"
		phone_numbers.each {|phone| puts phone}
	end

	def print_addresses
		puts "------Addresses------"
		addresses.each {|adress| puts adress.to_s}
	end
end

