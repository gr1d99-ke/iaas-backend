# frozen_string_literal: true

class OpeningSerializer < ActiveModel::Serializer
  type :openings
  attributes :id,
             :open,
             :title,
             :location,
             :company,
             :description,
             :qualifications,
             :start_date,
             :end_date


  attribute :open do
    object.end_date >= object.start_date
  end

  belongs_to :user

  has_many :applications

  def read_attribute_for_serialization(attr)
    object[attr.to_s]
  end
end
