require "./contact.rb"

class AddressBook
	attr_reader :contacts
	
	def initialize
		@contacts = []
	end

	def find_by_name(name)
		results = []
		search = name.downcase
		contacts.each do |contact|
			if contact.full_name.downcase.include?(search)
				results.push(contact)
			end
		end
		puts "Name search results (#{search})"
		print_results(results)
	end

	def find_by_phone_number(number)
		results = []
		search = number.gsub("-", "")
		contacts.each do |contact|
			contact.phone_numbers.each do |phone_number|
				if phone_number.number.gsub("-","").include?(search)
					results.push(contact)
				end
			end
		end
		puts "Phone search results (#{search})"
		print_results(results)
	end

	def print_results(results)
		results.each do |contact|
			puts contact.to_s('full_name')
			contact.print_phone_numbers
			contact.print_addresses
			puts "\n"
		end
	end

	def print_contact_list
		puts "------Contacts List------"
		contacts.each do |contact|
			puts contact.to_s("last_first")
		end
	end
end

address_book = AddressBook.new

melissa =  Contact.new
melissa.first_name = "Melissa"
melissa.middle_name = "carolina"
melissa.last_name = "Ramirez"
melissa.add_phone_number("Home", "3772016")
melissa.add_phone_number("Celphone", "320161648")
melissa.add_address("Home", "94", "202", "Bogota", "Colombia", "100221")

carlos = Contact.new
carlos.first_name = "Carlos"
carlos.last_name = "Holmes"
carlos.add_phone_number("Home", "8888888")
carlos.add_phone_number("Celphone", "320161648")
carlos.add_address("Home", "calle 12", "202", "Bogota", "Colombia", "100221")


address_book.contacts.push(melissa)
address_book.contacts.push(carlos)

#address_book.print_contact_list

#address_book.find_by_name('RAMI')

address_book.find_by_phone_number("320")