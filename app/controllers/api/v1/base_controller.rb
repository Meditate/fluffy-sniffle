class Api::V1::BaseController < ApplicationController
  before_action :token_authenticate_user!
end
