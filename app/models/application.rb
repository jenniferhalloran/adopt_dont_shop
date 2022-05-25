class Application < ApplicationRecord
	after_initialize :default_values

	has_many :pet_applications
	has_many :pets, through: :pet_applications

	validates_presence_of :name, :street_address, :city, :state, :zip_code

	def default_values
		self.status ||= "In Progress"
	end

	def has_pets?
		pets.count > 0
	end

	def approved?
		pet_applications.all?{ |pet_app| pet_app.application_status  == "Approved"  }
	end

	def rejected?
		pet_applications.any?{ |pet_app| pet_app.application_status  == "Rejected"  }

	end

	def approve_application
		update(status: "Approved")
		pets.each { |pet| pet.update(adoptable: false)}
		# require "pry"; binding.pry #when I pry in here
		# #the pet value is false
	end

	def reject_application
		update(status: "Rejected")
	end
end
