class ApplicationSignedInController < ApplicationController
  before_action :authenticate_user!
end
