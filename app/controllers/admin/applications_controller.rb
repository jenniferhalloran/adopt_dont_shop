class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if @application.approved?
      @application.approve_application
    elsif @application.rejected?
      @application.reject_application
    end
  end
end
