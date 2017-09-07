module Api::V1
  class OperativeNotesController < ApiController
    before_action :set_operative_note, only: [:show]

    # GET /operative_notes
    def index
      @operative_notes = OperativeNote.all
      json_response(@operative_notes)
    end

    
    # GET /operative_notes/:id
    def show
      json = {
        :id => @operative_note.id,
        :description => @operative_note.description,
        :find => @operative_note.find,
        :created_at => @operative_note.created_at.to_formatted_s(:iso8601),
        :updated_at => @operative_note.updated_at.to_formatted_s(:iso8601),
        :plan_id => @operative_note.plan_id,
        :diagnostic => @operative_note.diagnostic
      }
      json_response(json)
    end


    private
      def set_operative_note
        @operative_note = OperativeNote.find(params[:id])
      end

  end
end
