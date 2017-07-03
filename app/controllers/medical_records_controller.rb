class MedicalRecordsController < ApplicationController
  before_action :set_record, only: [:show, :update]

  # GET /medical_records
  def index
    @records = current_user.medical_records
    json = Array.new

    @records.each do |r|
      parsedRecord = {
        :address => r.address,
        :backgrounds => r.parsedBackgrounds,
        :birthday => r.birthday,
        :cellphone_number => r.cellphone_number,
        :created_at => r.created_at.to_formatted_s(:iso8601),
        :document => r.document,
        :document_type => r.document_type,
        :email => r.email,
        :first_consultation_date => r.first_consultation_date.to_formatted_s(:iso8601),
        :gender => r.gender,
        :id => r.id,
        :insurance => r.insurance,
        :last_name => r.last_name,
        :name => r.name,
        :occupation => r.occupation,
        :phone_number => r.phone_number,
        :physic_data => r.physic_data,
        :profile_picture => r.profile_picture.url,
        :referred_by => r.referred_by,
        :representative_document => r.representative_document,
        :updated_at => r.updated_at.to_formatted_s(:iso8601)
      }
      json << parsedRecord
    end

    json_response(json)
  end

  # GET /medical_records/:id
  def show
    json = {
      :address => @record.address,
      :backgrounds => @record.parsedBackgrounds,
      :birthday => @record.birthday,
      :cellphone_number => @record.cellphone_number,
      :created_at => @record.created_at.to_formatted_s(:iso8601),
      :document => @record.document,
      :document_type => @record.document_type,
      :email => @record.email,
      :first_consultation_date => @record.first_consultation_date.to_formatted_s(:iso8601),
      :gender => @record.gender,
      :id => @record.id,
      :insurance => @record.insurance,
      :last_name => @record.last_name,
      :name => @record.name,
      :occupation => @record.occupation,
      :phone_number => @record.phone_number,
      :physic_data => @record.physic_data,
      :profile_picture => @record.profile_picture.url,
      :referred_by => @record.referred_by,
      :representative_document => @record.representative_document,
      :updated_at => @record.updated_at.to_formatted_s(:iso8601)
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
