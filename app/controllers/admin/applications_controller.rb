class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])

    if @application.pets_added?
      if @application.all_approved?
        @application.approve_application
      elsif @application.all_reviewed?
        @application.reject_application
      end
    end
  end
end
