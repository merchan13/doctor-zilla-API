module Api::V1
  class SyncsController < ApiController

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
        :consultations => Sync.consultations,
        :medical_records => Sync.medical_records
      }
      json_response(json)
    end

    ## GET /latest_data
    # retrieves the X latest medical records (with all its consultations and misc data)
    def latest_data
      json_response(Sync.latest_data)
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

    def set_actions
      dict = params[:sync][:records_dictionary]

      puts dict

      actions = Array.new

      dict.each do |check_rec|
        record = MedicalRecord.find(check_rec)

        if record.updated_at.to_formatted_s(:iso8601) > dict[check_rec]
          action = {
            :id => record.id,
            :action => 2
          }
        elsif record.updated_at.to_formatted_s(:iso8601) < dict[check_rec]
          action = {
            :id => record.id,
            :action => 1
          }
        elsif record.updated_at.to_formatted_s(:iso8601) == dict[check_rec]
          action = {
            :id => record.id,
            :action => 0
          }
        end

        actions << action
      end

      json_response(actions)
    end

    private
      def sync_params
        params.require(:sync).permit( :sync_date, :description, :records_dictionary )
      end

  end
end
