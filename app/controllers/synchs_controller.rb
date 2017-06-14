class MedicalRecordsController < ApplicationController

  # GET /medical_records
  def index
    @synchs = Synch.all
    json = Array.new

    @synchs.each do |s|
      parsedSync = {  :id => s.id,
                      :description => s.description,
                      :created_at => r.created_at.to_formatted_s(:iso8601),
                      :updated_at => r.updated_at.to_formatted_s(:iso8601)
                    }
      json << parsedSync
    end

    json_response(json)
  end

  def create
    @synch = Sync.create!(synch_params)
    json_response(@synch, :created)
  end

  private
    def synch_params
      params.require(:synch).permit( :description )
    end

end
