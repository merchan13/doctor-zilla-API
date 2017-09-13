class Consultation < ApplicationRecord
  belongs_to :medical_record

  has_many :physical_exams
  has_many :consultation_diagnostics
  has_many :diagnostics, through: :consultation_diagnostics

  belongs_to :reason, optional: true

  has_one :plan

  def imc
    result = self.weight/((self.height/100) ** 2)
  end

  def parsedPE
    self.physical_exams.each do |b|
      b.exam_type = b.type_es
    end
  end

end
