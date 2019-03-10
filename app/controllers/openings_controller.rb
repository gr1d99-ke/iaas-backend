# frozen_string_literal: true

class OpeningsController < ApplicationController
  before_action :must_be_logged_in!, only: %i[create update destroy]
  before_action :must_be_admin!, only: %i[create update destroy]

  def index
    page, per_page = pagination_params
    openings = Opening.order(created_at: 'desc').paginate(page: page, per_page: per_page)
    render json: openings, meta: pagination_dict(openings)
  end

  def create
    opening = Opening.new(new_opening_params)
    opening.save

    if opening.valid?
      render json: opening
    else
      resource_invalid!(opening)
    end
  end

  def show
    opening = Opening.find_by(id: params[:id])
    if opening
      render_resource(opening)
    else
      render json: {}, status: :not_found
    end
  end

  def update
    opening = Opening.find_by(id: params[:id])

    if opening
      if opening.update(update_opening_params)
        render_resource(opening)
      else
        resource_invalid!(opening)
      end
    else
      render json: {}, status: :not_found
    end
  end

  def destroy
    opening = Opening.find_by(id: params[:id])

    if opening
      opening.destroy
    else
      render json: {}, status: :not_found
    end
  end

  private

  def new_opening_params
    params.require(:openings).permit(:title,
                                     :company,
                                     :location,
                                     :description,
                                     :qualifications,
                                     :start_date,
                                     :end_date).reverse_merge!(user_id: @current_user.id)
  end

  def update_opening_params
    params.require(:openings).permit(:title,
                                     :company,
                                     :location,
                                     :description,
                                     :qualifications,
                                     :start_date,
                                     :end_date)
  end

  def pagination_params
    page             = params[:page] && params[:page][:number] || 1
    per_page         = params[:page] && params[:page][:size] || WillPaginate.per_page
    [page, per_page]
  end
end
