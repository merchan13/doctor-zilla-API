module Api::V1
  class ActivitiesController < ApiController

    # GET /attachments
    def index

      @records = current_user.medical_records.all

      @records_total = @records.count
      @consultations_total = Consultation.where(medical_record: @records).count
      @procedures_total = 0

      if @consultations_total > 0
        @plans = Plan.where(consultation: Consultation.where(medical_record: @records))

        if @plans.count > 0
          @procedures_total = OperativeNote.where(plan: @plans).count
        end
      end

      json = {
        :records_total => @records_total,
        :consultations_total => @consultations_total,
        :procedures_total => @procedures_total
      }

      json_response(json)
    end

  end
end
