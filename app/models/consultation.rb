class Consultation < ApplicationRecord
  belongs_to :medical_record

  # Antecedentes
  has_many :backgrounds
  # Examen fisico
  has_many :physical_exams
  # Motivos de consulta
  belongs_to :reason, optional: true
  # Diagnóstico
  belongs_to :diagnostic, optional: true
  # Plan
  has_one :plan

  def imc
    result = self.weight/((self.height/100) ** 2)
  end

end
