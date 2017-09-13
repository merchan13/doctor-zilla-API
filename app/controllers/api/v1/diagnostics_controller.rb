module Api::V1
  class DiagnosticsController < ApiController
    before_action :set_diagnostic, only: [:show]

    # GET /diagnostics
    def index
      @diagnostics = Diagnostic.all
      json_response(@diagnostics)
    end

    # GET /diagnostics/:id
    def show
      json = {
        :id => @diagnostic.id,
        :description => @diagnostic.description,
        :created_at => @diagnostic.created_at.to_formatted_s(:iso8601),
        :updated_at => @diagnostic.updated_at.to_formatted_s(:iso8601),
      }

      json_response(json)
    end

    # GET /consultations/:consultation_id/diagnostics
    def index_consultation
      @consultation = Consultation.find(params[:consultation_id])
      @diagnostics = @consultation.diagnostics
      json_response(@diagnostics)
    end

    private
      def set_diagnostic
        @diagnostic = Diagnostic.find(params[:id])
      end

  end
end
