class PrescriptionsController < ApplicationController
  before_action :set_medical_record, only: [:index]
  before_action :set_prescription, only: [:show]

  # GET /prescriptions
  def index
    @prescriptions = @record.prescriptions
    json_response(@prescriptions)
  end

  # GET /prescriptions/:id
  def show
    json_response(@prescription)
  end

  # GET /medicines/:medicine_id/prescriptions
  def index_medicine
    @medicine = Medicine.find(params[:medicine_id])
    @prescriptions = @medicine.prescriptions
    json_response(@prescriptions)
  end

  private
    def set_prescription
      @prescription = Prescription.find(params[:id])
    end

    def set_medical_record
      @record = MedicalRecord.find(params[:record])
    end

end
