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
end
