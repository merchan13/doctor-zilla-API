class InsurancesController < ApplicationController

  # GET /insurances
  def index
    @insurances = Insurance.all
    json_response(@insurances)
  end

  # GET /insurances/:id
  def show
    @insurance = Insurance.find(params[:id])
    json_response(@insurance)
  end

end
