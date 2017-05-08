class PlanProcedure < ApplicationRecord
  belongs_to :plan
  belongs_to :procedure

  validates_presence_of :plan_id, :procedure_id
end
