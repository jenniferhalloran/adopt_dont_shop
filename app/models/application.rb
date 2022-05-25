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

	def pets_added?
		pet_applications.exists?
	end

	def all_approved?
    pet_applications.count == pet_applications.where(application_status: 'Approved').count
	end

	def all_reviewed?
		pet_applications.count == pet_applications.where("application_status IS NOT NULL").count

	end

	def approve_application
		update(status: "Approved")
		pets.each { |pet| pet.update(adoptable: false)}
	end

	def reject_application
		update(status: "Rejected")
	end
end
