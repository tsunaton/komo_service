class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :current_user
  before_action :set_request_from
end
