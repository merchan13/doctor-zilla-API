class SynchsController < ApplicationController
  #QUITAR ANTES DE PRODUCCION!
  skip_before_action :require_login!

  # GET /synchs
  def index
    @synchs = Synch.all
    json = Array.new

    @synchs.each do |s|
      parsedSync = {  :id => s.id,
                      :description => s.description,
                      :created_at => s.created_at.to_formatted_s(:iso8601)
                    }
      json << parsedSync
    end

    json_response(json)
  end

  # POST /synchs
  def create
    @synch = Sync.create!(synch_params)
    json_response(@synch, :created)
  end

  # GET /latest_updates
  def latest_updates
    json = {
      :backgrounds => Synch.backgrounds,
      :consultations => Synch.consultations,
      :medical_records => Synch.medical_records,
      :operative_notes => Synch.operative_notes,
      :physical_exams => Synch.physical_exams,
      :plans => Synch.plans
    }
    json_response(json)
  end

  # GET /last_synch
  def last_synch
    synch = Synch.last
    json = {
      :id => synch.id,
      :description => synch.description,
      :created_at => synch.created_at.to_formatted_s(:iso8601)
    }
    json_response(json)
  end

  private
    def synch_params
      params.require(:synch).permit( :description )
    end

end
