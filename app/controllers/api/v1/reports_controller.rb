module Api::V1
  class ReportsController < ApiController
    before_action :set_medical_record, only: [:index]
    before_action :set_report, only: [:show]

    # GET /reports
    def index
      @reports = @medical_record.reports
      json_response(@reports)
    end

    # GET /reports/:id
    def show
      json_response(@report)
    end

    private
      def set_report
        @report = Report.find(params[:id])
      end

      def set_medical_record
        @medical_record = MedicalRecord.find(params[:medical_record])
      end
  end
end
