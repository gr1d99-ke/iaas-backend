# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  attributes :id,
             :cover_letter,
             :resume

  belongs_to :applicant
  belongs_to :opening

  def cover_letter
    object.cover_letter.url
  end

  def resume
    object.resume.url
  end
end
