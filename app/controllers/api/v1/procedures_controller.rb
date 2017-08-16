module Api::V1
  class ProceduresController < ApiController

    # GET /procedures
    def index
      @procedures = Procedure.all
      json_response(@procedures)
    end

    # GET /procedures/:id
    def show
      @procedure = Procedure.find(params[:id])
      json_response(@procedure)
    end

    # GET /plans/:plan_id/procedures
    def index_plan
      @plan = Plan.find(params[:plan_id])
      @procedures = @plan.procedures
      json_response(@procedures)
    end

  end
end
