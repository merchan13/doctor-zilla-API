module Api::V1
  class MedicalRecordsController < ApiController
    before_action :set_record, only: [:show, :update]

    # GET /medical_records
    def index
      @records = current_user.medical_records
      json = Array.new

      @records.each do |r|
        json << r.complete_info
      end

      json_response(json)
    end

    # GET /medical_records/:id
    def show
      json_response(@record.complete_info)
    end

    # PUT /medical_records/:id
    def update
      @record.update(record_params)
      head :no_content
    end

    # GET /search_records
    def search
      @records = current_user.medical_records.search(params[:search_param])
      json_response(@records)
    end

    private
      def record_params
        params.require(:medical_record).permit( :document, :document_type, :first_consultation_date, :name, :last_name,
                                                :birthday, :gender, :phone_number, :cellphone_number, :address, :email,
                                                :referred_by, :profile_picture, :representative_document, :occupation_id,
                                                :insurance_id )
      end

      def set_record
        @record = MedicalRecord.find(params[:id])
      end

  end
end
