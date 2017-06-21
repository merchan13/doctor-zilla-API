class PhysicalExamsController < ApplicationController
  before_action :set_consultation, only: [:index]
  before_action :set_physical_exam, only: [:show, :update]

  # GET /physical_exams
  def index
    @physical_exams = @consultation.physical_exams
    json = Array.new
    @physical_exams.each do |pe|
      parsedPE = {
        :consultation_id => pe.consultation_id,
        :created_at => pe.created_at.to_formatted_s(:iso8601),
        :exam_type => pe.exam_type,
        :id => pe.id,
        :observation => pe.observation,
        :updated_at => pe.updated_at.to_formatted_s(:iso8601),
        :url => pe.url
      }
      json << parsedPE
    end

    json_response(json)
  end

  # GET /physical_exams/:id
  def show
    json_response(@physical_exam)
  end

  # PUT /physical_exams/:id
  def update
    @physical_exam.update(physical_exam_params)
    head :no_content
  end

  private
    def physical_exam_params
      params.require(:physical_exam).permit( :exam_type, :url, :observation, :consultation_id )
    end

    def set_physical_exam
      @physical_exam = PhysicalExam.find(params[:id])
    end

    def set_consultation
      @consultation = Consultation.find(params[:consultation])
    end

end
