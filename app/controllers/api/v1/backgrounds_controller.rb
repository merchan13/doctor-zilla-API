module Api::V1
  class BackgroundsController < ApiController
    before_action :set_medical_record, only: [:index]
    before_action :set_background, only: [:show, :update]

    # GET /backgrounds
    def index
      @backgrounds = @medical_record.backgrounds
      json = Array.new

      @backgrounds.each do |b|
        parsedBackground = {
          :background_type => b.type_es,
          :medical_record_id => b.medical_record_id,
          :created_at => b.created_at.to_formatted_s(:iso8601),
          :description => b.description,
          :id => b.id,
          :updated_at => b.updated_at.to_formatted_s(:iso8601)
        }
        json << parsedBackground
      end

      json_response(json)
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
        params.require(:background).permit( :background_type, :description, :medical_record_id )
      end

      def set_background
        @background = Background.find(params[:id])
      end

      def set_medical_record
        @medical_record = MedicalRecord.find(params[:record])
      end

  end
end
