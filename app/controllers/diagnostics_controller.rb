class DiagnosticsController < ApplicationController

  # GET /diagnostics
  def index
    @diagnostics = Diagnostic.all
    json_response(@diagnostics)
  end

  # GET /diagnostics/:id
  def show
    @diagnostic = Diagnostic.find(params[:id])
    json_response(@diagnostic)
  end

end
