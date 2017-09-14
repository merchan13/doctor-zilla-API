module Api::V1
  class ConsultationsController < ApiController
    before_action :set_medical_record, only: [:index]
    before_action :set_consultation, only: [:show, :update]

    # GET /consultations
    def index
      @consultations = @record.consultations
      json = Array.new

      @consultations.each do |c|
        # set de plan
        parsedPlan = Hash.new
        if !c.plan.nil?
          parsedOperativeNote = Hash.new
          if !c.plan.operative_note.nil?
            parsedOperativeNote = {
              :id => c.plan.operative_note.id,
              :description => c.plan.operative_note.description,
              :find => c.plan.operative_note.find,
              :created_at => c.plan.operative_note.created_at.to_formatted_s(:iso8601),
              :updated_at => c.plan.operative_note.updated_at.to_formatted_s(:iso8601),
              :plan_id => c.plan.operative_note.plan_id,
              :diagnostic => c.plan.operative_note.diagnostic
            }
          end

          parsedPlan = {
            :id => c.plan.id,
            :description => c.plan.description,
            :emergency => c.plan.emergency,
            :created_at => c.plan.created_at.to_formatted_s(:iso8601),
            :updated_at => c.plan.updated_at.to_formatted_s(:iso8601),
            :consultation_id => c.plan.consultation_id,
            :operative_note => parsedOperativeNote,
            :procedures => c.plan.procedures
          }
        end
        # set de examenes fisicos
        parsedPhysicalExams = Array.new
        c.physical_exams.each do |pe|
          parsedPE = {
            :id => pe.id,
            :exam_type => pe.type_es,
            :url => pe.url,
            :observation => pe.observation,
            :created_at => pe.created_at.to_formatted_s(:iso8601),
            :updated_at => pe.updated_at.to_formatted_s(:iso8601),
            :consultation_id => pe.consultation_id
          }
          parsedPhysicalExams << parsedPE
        end
        # set de diagnosticos
        parsedDiagnostics = Array.new
        c.diagnostics.each do |dx|
          parsedDX = {
            :id => dx.id,
            :url => dx.description,
            :created_at => dx.created_at.to_formatted_s(:iso8601),
            :updated_at => dx.updated_at.to_formatted_s(:iso8601)
          }
          parsedDiagnostics << parsedDX
        end

        parsedConsultation = {
          :affliction => c.affliction,
          :created_at => c.created_at.to_formatted_s(:iso8601),
          :diagnostics => parsedDiagnostics,
          :evolution => c.evolution,
          :height => c.height,
          :id => c.id,
          :medical_record_id => c.medical_record_id,
          :note => c.note,
          :physical_exams => parsedPhysicalExams,
          :plan => parsedPlan,
          :pressure_s => c.pressure_s,
          :pressure_d => c.pressure_d,
          :reason => c.reason,
          :updated_at => c.updated_at.to_formatted_s(:iso8601),
          :weight => c.weight
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
        :diagnostics => @consultation.diagnostics,
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
        :weight => @consultation.weight,
        :physical_exams => @consultation.parsedPE
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
end
