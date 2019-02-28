# frozen_string_literal: true

class OpeningsController < ApplicationController
  before_action :must_be_logged_in!, only: %i[create]
  before_action :must_be_admin!, only: %i[create]

  def create
    opening = Opening.new(opening_params)
    opening.save

    if opening.valid?
      render json: opening
    else
      resource_invalid!(opening)
    end
  end

  private

  def opening_params
    params.require(:openings).permit(:title,
                                     :company,
                                     :location,
                                     :description,
                                     :qualifications,
                                     :start_date,
                                     :end_date).reverse_merge!(user_id: @current_user.id)
  end
end
