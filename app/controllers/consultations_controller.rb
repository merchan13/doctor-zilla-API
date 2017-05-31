class ConsultationsController < ApplicationController
  before_action :set_medical_record, only: [:index]
  before_action :set_consultation, only: [:show, :update]

  # GET /consultations
  def index
    @consultations = @record.consultations
    json = Array.new

    @consultations.each do |c|
      parsedConsultation = {  :affliction => c.affliction,
                              :created_at => c.created_at.to_formatted_s(:iso8601),
                              :diagnostic => c.diagnostic,
                              :evolution => c.evolution,
                              :height => c.height,
                              :id => c.id,
                              :medical_record_id => c.medical_record_id,
                              :note => c.note,
                              :plan => c.plan,
                              :pressure_s => c.pressure_s,
                              :pressure_d => c.pressure_d,
                              :reason => c.reason,
                              :updated_at => c.updated_at.to_formatted_s(:iso8601),
                              :weight => c.weight,
                              :backgrounds => c.backgrounds,
                              :physical_exams => c.physical_exams
                            }
      json << parsedConsultation
    end

    json_response(json)
  end

  # GET /consultations/:id
  def show
    json = {
              :affliction => @consultation.affliction,
              :created_at => @consultation.created_at.to_formatted_s(:iso8601),
              :diagnostic => @consultation.diagnostic,
              :evolution => @consultation.evolution,
              :height => @consultation.height,
              :id => @consultation.id,
              :medical_record_id => @consultation.medical_record_id,
              :note => @consultation.note,
              :plan => @consultation.plan,
              :pressure_s => @consultation.pressure_s,
              :pressure_d => @consultation.pressure_d,
              :reason => @consultation.reason,
              :updated_at => @consultation.updated_at.to_formatted_s(:iso8601),
              :weight => @consultation.weight
              #Antecedentes
              #Examen fisico
    }
    json_response(json)
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
