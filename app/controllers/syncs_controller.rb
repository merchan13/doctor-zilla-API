class SyncsController < ApplicationController
  #QUITAR ANTES DE PRODUCCION!
  skip_before_action :require_login!

  # GET /syncs
  def index
    @syncs = sync.all
    json = Array.new

    @syncs.each do |s|
      parsedSync = {  :id => s.id,
                      :description => s.description,
                      :created_at => s.created_at.to_formatted_s(:iso8601)
                    }
      json << parsedSync
    end

    json_response(json)
  end

  # POST /syncs
  def create
    @sync = Sync.create!(sync_params)
    json_response(@sync, :created)
  end

  # GET /latest_updates
  def latest_updates
    json = {
      :backgrounds => sync.backgrounds,
      :consultations => sync.consultations,
      :medical_records => sync.medical_records,
      :operative_notes => sync.operative_notes,
      :physical_exams => sync.physical_exams,
      :plans => sync.plans
    }
    json_response(json)
  end

  # GET /last_sync
  def last_sync
    sync = sync.last
    json = {
      :id => sync.id,
      :description => sync.description,
      :created_at => sync.created_at.to_formatted_s(:iso8601)
    }
    json_response(json)
  end

  private
    def sync_params
      params.require(:sync).permit( :description )
    end

end
