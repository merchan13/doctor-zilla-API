class SynchsController < ApplicationController

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
      :backgrounds => Sync.backgrounds,
      :consultations => Sync.consultations,
      :medical_records => Sync.medical_records,
      :operative_notes => Sync.operative_notes,
      :physical_exams => Sync.physical_exams,
      :plans => Sync.plans
    }
    json_response(json)
  end

  def last_synch
    synch = Synch.last
    json = {
      :id => synch.id,
      :description => synch.description,
      :created_at => synch.created_at.to_formatted_s(:iso8601)
    }
  end

  private
    def synch_params
      params.require(:synch).permit( :description )
    end

end
