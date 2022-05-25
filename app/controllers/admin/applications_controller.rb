class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if @application.approved?
      @application.update(status: "Approved")
    elsif @application.rejected?
      @application.update(status: "Rejected")
  end
end

