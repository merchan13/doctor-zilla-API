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

    # PUT /medical_records/:medical_record_id/backgrounds
    def update_record_backgrounds
      @record = MedicalRecord.find(params[:medical_record_id])

      @record.update_background("family", params[:bg_family])
      @record.update_background("allergy", params[:bg_allergy])
      @record.update_background("diabetes", params[:bg_diabetes])
      @record.update_background("asthma", params[:bg_asthma])
      @record.update_background("heart", params[:bg_heart])
      @record.update_background("medicine", params[:bg_medicine])
      @record.update_background("surgical", params[:bg_surgical])
      @record.update_background("other", params[:bg_other])

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
