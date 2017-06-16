class SyncsController < ApplicationController
  #QUITAR ANTES DE PRODUCCION!
  skip_before_action :require_login!

  # GET /syncs
  def index
    @syncs = Sync.all
    json = Array.new

    @syncs.each do |s|
      parsedSync = {  :id => s.id,
                      :date => s.sync_date.to_formatted_s(:iso8601),
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
      :backgrounds => Sync.backgrounds,
      :consultations => Sync.consultations,
      :medical_records => Sync.medical_records,
      :operative_notes => Sync.operative_notes,
      :physical_exams => Sync.physical_exams,
      :plans => Sync.plans
    }
    json_response(json)
  end

  # GET /last_sync
  def last_sync
    sync = Sync.last
    json = {
      :id => sync.id,
      :sync_date => sync.sync_date.to_formatted_s(:iso8601),
      :description => sync.description,
      :created_at => sync.created_at.to_formatted_s(:iso8601)
    }
    json_response(json)
  end

  private
    def sync_params
      params.require(:sync).permit( :sync_date, :description )
    end

end
