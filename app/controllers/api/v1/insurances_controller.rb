module Api::V1
  class InsurancesController < ApiController

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
end
