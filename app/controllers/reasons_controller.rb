class ReasonsController < ApplicationController

  # GET /reasons
  def index
    @reasons = reason.all
    json_response(@reasons)
  end

  # GET /reasons/:id
  def show
    @reason = reason.find(params[:id])
    json_response(@reason)
  end

end
