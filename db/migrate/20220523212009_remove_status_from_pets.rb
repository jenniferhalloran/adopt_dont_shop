class RemoveStatusFromPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :status, :string
    add_column :pet_applications, :application_status, :string
  end
end
