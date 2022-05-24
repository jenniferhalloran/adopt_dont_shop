class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy
  has_many :applications, through: :pets

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def self.rev_alphabetize
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC;")
  end

  def self.shelters_with_pending_apps
    joins(:applications).where("applications.status = 'Pending'").order(:name)
  end

  def self.name_and_address(shelter_id)
    find_by_sql("SELECT name, street_address, city, state, zip_code FROM shelters WHERE shelters.id = #{shelter_id}")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def adoptable_pets_count
    adoptable_pets.count
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end

  def avg_adoptable_pet_age
    pets.where(adoptable: true).average(:age).to_f
  end

  def adopted_pets_count
    # pets.joins(:applications).where(applications: {status: "Approved"}).count
    pets.joins(:applications).where("applications.status = 'Approved'").count
  end
end
