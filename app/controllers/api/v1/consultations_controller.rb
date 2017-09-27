module Api::V1
  class ConsultationsController < ApiController
    before_action :set_medical_record, only: [:index]
    before_action :set_consultation, only: [:show, :update]

    # GET /consultations
    def index
      @consultations = @record.consultations
      json = Array.new

      @consultations.each do |c|
        json << c.complete_info
      end

      json_response(json)
    end

    # GET /consultations/:id
    def show
      json_response(@consultation.complete_info)
    end

    # PUT /consultations/:id
    def update
      @consultation.update(consultation_params)
      head :no_content
    end

    private
      def consultation_params
        params.require(:consultation).permit( :evolution, :note, :affliction, :weight, :height, :pressure_s,
                                              :pressure_d, :diagnostic_id, :reason_id )
      end

      def set_consultation
        @consultation = Consultation.find(params[:id])
      end

      def set_medical_record
        @record = MedicalRecord.find(params[:record])
      end

  end
end
