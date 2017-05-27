class MedicalRecordsController < ApplicationController
  before_action :set_record, only: [:show, :update, :physic_data, :backgrounds]

  # GET /medical_records
  def index
    @records = current_user.medical_records
    json_response(@records)
  end

  # GET /medical_records/:id
  def show
    json = {  :address => @records.address,
              :background => @record.backgrounds,
              :birthday => @record.birthday,
              :cellphone_number: => @record.cellphone_number,
              :created_at => @record.created_at,
              :document => @record.document,
              :document_type => @record.document_type,
              :email => @record.email,
              :first_consultation_date => @record.first_consultation_date,
              :gender => @record.gender,
              :id => @record.id,
              :insurance => @record.insurance.name,
              :last_name => @record.last_name,
              :name => @record.name,
              :occupation_id => @record.occupation.name,
              :phone_number => @record.phone_number,
              :physic_data => @record.physic_data
              :profile_picture => @record.profile_picture.url,
              :referred_by => @record.referred_by,
              :representative_document => @record.representative_document,
              :updated_at => @record.updated_at
            }
    json_response(json)
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

  # GET /medical_records/physic_data/:id
  def physic_data
    json_response(@record.physic_data)
  end

  # GET /medical_records/backgrounds/:id
  def physic_data
    json_response(@record.backgrounds)
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
