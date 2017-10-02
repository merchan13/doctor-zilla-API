module Api::V1
  class ConsultationsController < ApiController
    before_action :set_medical_record, only: [:index, :create]
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

    # POST /consultations
    def create
      Consultation.transaction do
        @reason = Reason.where(description: 'Nota agregada desde App Móvil').first

        if @reason.nil?
          @reason = Reason.create(description: 'Nota agregada desde App Móvil')
        end

        @consultation = @record.consultations.create(consultation_params)

        json_response(@consultation, :created)
      end
    end

    # GET /consultations/:id
    def show
      json_response(@consultation.complete_info)
    end

    # PUT /consultations/:id
    def update
      Consultation.transaction do
        @consultation.update(note: consultation_params[:note], reason: @reason)
        head :no_content
      end
    end

    private
      def consultation_params
        params.require(:consultation).permit( :evolution, :note, :affliction, :weight, :height, :pressure_s,
                                              :pressure_d, :diagnostic_id, :reason_id, :record )
      end

      def set_consultation
        @consultation = Consultation.find(params[:id])
      end

      def set_medical_record
        @record = MedicalRecord.find(params[:record])
      end

  end
end
