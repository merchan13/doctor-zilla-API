class PhysicalExamsController < ApplicationController
  before_action :set_consultation, only: [:index]
  before_action :set_physical_exam, only: [:show, :update]

  # GET /physical_exams
  def index
    @physical_exams = @consultation.physical_exams
    json_response(@physical_exams)
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
