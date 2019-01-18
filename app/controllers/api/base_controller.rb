class Api::BaseController < ApplicationController
  before_action :token_authenticate_user!
end
