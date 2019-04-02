class ApplicationsController < ApplicationController
  before_action :must_be_logged_in!, only: :create
  def create
    application = Application.new(application_params)
    application.resume = attachment_data["resume_data"]
    application.cover_letter = attachment_data["cover_letter_data"]

    if application.valid?
      application.save
      render_resource(application)
    else
      resource_invalid!(application)
    end
  end

  private

  def application_params
    params.require(:application).permit(:opening_id).merge!(user_id: @current_user.id, opening_id: params[:opening_id])
  end

  def attachment_data
    params.require(:application).permit(:resume_data, :cover_letter_data)
  end
end
