class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :update]

  # GET /plans/:id
  def show
    json_response(@plan)
  end

  # PUT /plans/:id
  def update
    @plan.update(plan_params)
    head :no_content
  end

  # GET /procedures/:procedure_id/plans
  def index_procedure
    @procedure = Procedure.find(params[:procedure_id])
    @plans = @procedure.plans
    json_response(@plans)
  end

  private
    def plan_params
      params.require(:plan).permit( :plan_type, :description, :consultation_id )
    end

    def set_plan
      @plan = Plan.find(params[:id])
    end

end
