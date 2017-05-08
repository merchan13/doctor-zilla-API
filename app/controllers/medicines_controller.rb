class MedicinesController < ApplicationController

  # GET /medicines
  def index
    @medicines = Medicine.all
    json_response(@medicines)
  end

  # GET /medicines/:id
  def show
    @medicine = Medicine.find(params[:id])
    json_response(@medicine)
  end

  # GET /prescriptions/:prescription_id/medicines
  def index_prescription
    @prescription = Prescription.find(params[:prescription_id])
    @medicines = @prescription.medicines
    json_response(@medicines)
  end

end
