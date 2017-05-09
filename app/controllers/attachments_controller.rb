class AttachmentsController < ApplicationController
  before_action :set_medical_record, only: [:index]
  before_action :set_attachment, only: [:show]

  # GET /attachments
  def index
    @attachments = @medical_record.attachments
    json_response(@attachments)
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
      @medical_record = MedicalRecord.find(params[:medical_record])
    end

end
