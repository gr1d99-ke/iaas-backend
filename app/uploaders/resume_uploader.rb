# frozen_string_literal: true

class ResumeUploader < Shrine
  plugin :validation_helpers

  Shrine::Attacher.validate do
    validate_mime_type_inclusion %w[application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document]
  end
end
