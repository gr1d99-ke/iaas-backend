# frozen_string_literal: true
require "will_paginate/array"

class OpeningsController < ApplicationController
  before_action :must_be_logged_in!, only: %i[create update destroy]
  before_action :optional_login,     only: %i[index]
  before_action :must_be_admin!,     only: %i[create update destroy]

  def index
    page, per_page = pagination_params
    openings = RedisService.get(openings_key)

    if openings.nil? || openings == "[]"
      openings = current_user_or_model.order(created_at: 'desc').to_json
      RedisService.set(openings_key, openings)
    end

    openings = JSON.parse(openings)
    openings = openings.paginate(page: page, per_page: per_page)

    render json: openings, each_serializer: OpeningSerializer, meta: pagination_dict(openings)
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
    params.require(:opening).permit(:title,
                                     :company,
                                     :location,
                                     :description,
                                     :qualifications,
                                     :start_date,
                                     :end_date).reverse_merge!(user_id: @current_user.id)
  end

  def update_opening_params
    params.require(:opening).permit(:title,
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

  def current_user_or_model
    return Opening if @current_user&.role.blank?

    return @current_user&.openings if @current_user

    Opening
  end

  def openings_key
    return "openings:#{@current_user.email.split("@")[0]}" if @current_user&.admin?

    "openings:all"
  end
end
