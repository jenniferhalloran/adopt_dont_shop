class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.rev_alphabetize
    @pending = Shelter.shelters_with_pending_apps
  end

  def show
    @shelter = Shelter.name_and_address(params[:id]).first
    @shelter_info = Shelter.find(params[:id])
  end
end
