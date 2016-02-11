class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  rescue_from ActionController::ParameterMissing, with: :parameter_is_missing

  protected

  def parameter_is_missing
    return render json: {error: {code: 3, desc: 'Параметр не указан'}}, status: 400
  end
end