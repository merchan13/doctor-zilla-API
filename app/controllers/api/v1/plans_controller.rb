module Api::V1
  class PlansController < ApiController
    before_action :set_plan, only: [:show]

    # GET /plans/:id
    def show
      json = {
        :id => @plan.id,
        :consultation_id => @plan.consultation_id,
        :description => @plan.description,
        :emergency => @plan.emergency,
        :created_at => @plan.created_at.to_formatted_s(:iso8601),
        :updated_at => @plan.updated_at.to_formatted_s(:iso8601),
        :operative_note => @plan.operative_note
      }

      json_response(json)
    end

    # GET /procedures/:procedure_id/plans
    def index_procedure
      @procedure = Procedure.find(params[:procedure_id])
      @plans = @procedure.plans
      json_response(@plans)
    end

    private
      def set_plan
        @plan = Plan.find(params[:id])
      end

  end
end
