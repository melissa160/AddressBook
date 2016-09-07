require "./contact.rb"
require "yaml"

class AddressBook
	attr_reader :contacts
	
	def initialize
		@contacts = []
		open()
	end

	def open
		if File.exist?("contacts.yml")
			@contacts = YAML.load_file("contacts.yml")
		end
	end

	def save
		File.open("contacts.yml", "w") do |file|
			#file.write(contacts.to_yaml)---this is another way for do the same
			file.write(YAML.dump(contacts))
		end
	end

	def remove
		print "Write the name or last name to remove: "
		remove_title = gets.chomp
		delete_contact(remove_title)

	end

	def delete_contact(remove_title)
		contacts.each do |contact|
			if contact.full_name.downcase.include?(remove_title)
				contacts.delete(contact)
			end
		end
		save
	end

	def run
		loop do
			puts "ADDRESS BOOK MENU"
			puts "a: Add Contact"
			puts "p: Print Address Book"
			puts "s: Search"
			puts "r: Remove"
			puts "e: Exit"
			print "Enter your choice: "
			input = gets.chomp.downcase
			case input
			when 'a'
				add_contact
			when 'p'
				print_contact_list
			when 's'
				print "Search term: "
				search = gets.chomp
				find_by_name(search)
				find_by_phone_number(search)
			when 'r'
				remove()
			when 'e'
				save()
				break
			end
		end
	end

	def add_contact
		contact = Contact.new
		print "First Name: "
		contact.first_name = gets.chomp
		print "Middle Name: "
		contact.middle_name = gets.chomp
		print "Last Name: "
		contact.last_name = gets.chomp

		loop do
			puts "Add phone number or address"
			puts "p: Add phone number"
			puts "a: Add address"
			puts "Any other key to go back"
			response = gets.chomp.downcase
			case response
			when 'p'
				phone = PhoneNumber.new
				print "Phone number kind (home, work, etc): "
				phone.kind = gets.chomp
				print "Phone number: "
				phone.number = gets.chomp
				contact.phone_numbers.push(phone)
			when 'a'
				address = Address.new
				print "Address kind (home, work, etc): "
				address.kind = gets.chomp
				print "Address street 1: "
				address.street_1 = gets.chomp
				print "Address street 2: "
				address.street_2 = gets.chomp
				print "Address City: "
				address.city = gets.chomp
				print "Address State: "
				address.state = gets.chomp
				print "Address postasl code: "
				address.postal_code = gets.chomp
				contact.addresses.push(address)
			else
				print "\n"
				break
			end
		end

		contacts.push(contact)	
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
address_book.run