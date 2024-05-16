# frozen_string_literal: true

module ApiExceptions
  UtilityAPIError = Class.new(StandardError)
  BadRequestError = Class.new(UtilityAPIError)
  UnauthorizedError = Class.new(UtilityAPIError)
  ApiRequestsQuotaReachedError = Class.new(UtilityAPIError)
  NotFoundError = Class.new(UtilityAPIError)
  UnprocessableEntityError = Class.new(UtilityAPIError)
  ApiError = Class.new(UtilityAPIError)
end