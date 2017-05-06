class OccupationsController < ApplicationController

  # GET /occupations
  def index
    @occupations = Occupation.all
    json_response(@occupations)
  end

  # GET /occupations/:id
  def show
    @occupation = Occupation.find(params[:id])
    json_response(@occupation)
  end

end
