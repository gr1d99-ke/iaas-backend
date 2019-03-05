# frozen_string_literal: true

class OpeningSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :location,
             :company,
             :description,
             :qualifications,
             :start_date,
             :end_date

  belongs_to :user
end
