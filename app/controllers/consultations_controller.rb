class ConsultationsController < ApplicationController
  before_action :set_medical_record, only: [:index]
  before_action :set_consultation, only: [:show, :update]

  # GET /consultations
  def index
    @consultations = @record.consultations
    json_response(@consultations)
  end

  # GET /consultations/:id
  def show
    json_response(@consultation)
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
