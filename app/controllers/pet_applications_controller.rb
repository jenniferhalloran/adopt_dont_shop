class PetApplicationsController < ApplicationController

	def create
		app = PetApplication.create!(pet_id: params[:pet_id], application_id: params[:id])
		redirect_to "/applications/#{params[:id]}"
	end

	def update
        pet_application = PetApplication.find(params[:id])
        pet_application.update(application_status: params[:application_status])
        redirect_to "/admin/applications/#{pet_application.application.id}"
    end
end
