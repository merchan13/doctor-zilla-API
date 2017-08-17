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
      json_response(@operative_note)
    end

    private
      def set_operative_note
        @operative_note = OperativeNote.find(params[:id])
      end

  end
end
