class BackgroundsController < ApplicationController
  before_action :set_consultation, only: [:index]
  before_action :set_background, only: [:show, :update]

  # GET /backgrounds
  def index
    @backgrounds = @consultation.backgrounds
    json_response(@backgrounds)
  end

  # GET /backgrounds/:id
  def show
    json_response(@background)
  end

  # PUT /backgrounds/:id
  def update
    @background.update(background_params)
    head :no_content
  end

  private
    def background_params
      params.require(:background).permit( :background_type, :description, :consultation_id )
    end

    def set_background
      @background = Background.find(params[:id])
    end

    def set_consultation
      @consultation = Consultation.find(params[:consultation])
    end

end
