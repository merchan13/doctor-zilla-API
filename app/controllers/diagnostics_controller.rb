class DiagnosticsController < ApplicationController

  # GET /diagnostics
  def index
    @diagnostics = diagnostic.all
    json_response(@diagnostics)
  end

  # GET /diagnostics/:id
  def show
    @diagnostic = diagnostic.find(params[:id])
    json_response(@diagnostic)
  end

end
