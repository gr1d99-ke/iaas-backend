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
    object["end_date"].to_date >= object["start_date"].to_date
  end

  def start_date
    object.start_date.to_date
  end

  def end_date
    object.end_date.to_date
  end

  belongs_to :user do
    user_id = object[:user_id.to_s]
    User.find(user_id) if user_id
  end

  has_many :applications

  def read_attribute_for_serialization(attr)
    object[attr.to_s]
  end
end
