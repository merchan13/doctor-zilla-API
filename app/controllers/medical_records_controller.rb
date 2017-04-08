class MedicalRecordsController < ApplicationController
  before_action :set_record, only: [:edit, :update, :show]

  # GET /medical_records
  def index
    @records = MedicalRecord.all
    json_response(@records)
  end

  # GET /medical_records/:id
  def show
    json_response(@record)
  end

  # PUT /medical_records/:id
  def update
    @record.update(record_params)
    head :no_content
  end

  # DELETE /medical_records/:id
  def destroy
    @record.destroy
    head :no_content
  end

  private
    def record_params
      params.require(:medical_record).permit( :document, :document_type, :first_consultation_date, :name, :last_name,
                                              :birth_date, :gender, :phone_number, :cellphone_number, :address, :email,
                                              :referred_by, :profile_picture, :representative_document )
    end

    def set_record
      @record = MedicalRecord.find(params[:id])
    end

end
