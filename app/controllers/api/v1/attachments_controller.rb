module Api::V1
  class AttachmentsController < ApiController
    before_action :set_medical_record, only: [:index]
    before_action :set_attachment, only: [:show]

    # GET /attachments
    def index
      @attachments = @medical_record.attachments
      json = Array.new

      @attachments.each do |a|
        parsedAttachment = {
          :id => a.id,
          :description => a.description,
          :url => a.url.url,
          :medical_record_id => a.medical_record_id,
          :created_at => a.created_at.to_formatted_s(:iso8601),
          :updated_at => a.updated_at.to_formatted_s(:iso8601)
        }

        json << parsedAttachment
      end

      json_response(json)
    end

    # GET /attachments/:id
    def show
      json_response(@attachment)
    end

    private
      def set_attachment
        @attachment = Attachment.find(params[:id])
      end

      def set_medical_record
        @medical_record = MedicalRecord.find(params[:record])
      end

  end
end
