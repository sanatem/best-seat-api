class Api::BaseController < ApplicationController

  private

  def render_json(serializer, data, extra = {})
    render json: serializer.new(data, extra)
  end

  def render_not_found_response(message)
    render_response(message, 404)
  end

  def render_success_response(message)
    render_response(message, 200)
  end

  def render_error_response(message)
    render_response(message, 400)
  end

  def render_partial_success_response(message, errors)
    render json: { message: message, errors: errors }, status: :ok
  end

  def render_response(message, code)
    render json: { message: message }, status: code
  end
end
