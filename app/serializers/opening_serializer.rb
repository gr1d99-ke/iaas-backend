# frozen_string_literal: true

class OpeningSerializer < ActiveModel::Serializer
  attributes :id,
             :open,
             :title,
             :location,
             :company,
             :description,
             :qualifications,
             :start_date,
             :end_date

  def open
    object.end_date >= object.start_date
  end

  def start_date
    object.start_date.to_date
  end

  def end_date
    object.end_date.to_date
  end

  belongs_to :user
  has_many :applications
end
