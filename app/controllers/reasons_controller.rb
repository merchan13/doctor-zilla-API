class ReasonsController < ApplicationController

  # GET /reasons
  def index
    @reasons = Reason.all
    json_response(@reasons)
  end

  # GET /reasons/:id
  def show
    @reason = Reason.find(params[:id])
    json_response(@reason)
  end

end
