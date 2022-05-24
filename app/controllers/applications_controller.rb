class ApplicationsController < ApplicationController
	def show
		@application = Application.find(params[:id])
		if params[:search_by_name].present?
			@matching_pets = Pet.search(params[:search_by_name])
		end
	end

	def new
	end

	def create
		application = Application.create(application_params)
		if application.save
			redirect_to "/applications/#{application.id}"
		else
			flash[:notice] = "Error: Please fill out all required fields!"
			render :new
			# redirect_to "/applications/new", alert: "Error: Please fill out all required fields!"
		end
	end

	def update
		application = Application.find(params[:id])
		application.update(description: params[:description], status: "Pending")
 		redirect_to "/applications/#{application.id}"
	end

private
	def application_params
		params.permit(:name, :street_address, :city, :state, :zip_code, :description)
	end
end
