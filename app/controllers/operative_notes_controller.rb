class OperativeNotesController < ApplicationController
  before_action :set_operative_note, only: [:show, :update]

  # GET /operative_notes/:id
  def show
    json_response(@operative_note)
  end

  # PUT /operative_notes/:id
  def update
    @operative_note.update(operative_note_params)
    head :no_content
  end

  private
    def operative_note_params
      params.require(:operative_note).permit( :description, :find, :plan_id )
    end

    def set_operative_note
      @operative_note = OperativeNote.find(params[:id])
    end

end
