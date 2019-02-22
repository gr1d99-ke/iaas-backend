# frozen_string_literal: true

module Errors
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
        param = parameter_missing_exception.param
        message = I18n.t("errors.parameter_missing.error_message")
        error = [
            { "#{param}": [message] }
        ]
        parameter_missing!(error)
      end
    end
  end
end
