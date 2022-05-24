class PetApplicationsController < ApplicationController

	def create
		app = PetApplication.create!(pet_id: params[:pet_id], application_id: params[:application_id])
		redirect_to "/applications/#{params[:application_id]}"
	end

	def update
        pet_application = PetApplication.find(params[:id])
        pet_application.update(application_status: params[:application_status])
        redirect_to "/admin/applications/#{pet_application.application.id}"
    end
end

