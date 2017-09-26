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

  def complete_info
    # set de plan
      parsedPlan = Hash.new
      if !self.plan.nil?
        parsedOperativeNote = Hash.new
        if !self.plan.operative_note.nil?
          parsedOperativeNote = {
            :id => self.plan.operative_note.id,
            :description => self.plan.operative_note.description,
            :find => self.plan.operative_note.find,
            :created_at => self.plan.operative_note.created_at.to_formatted_s(:iso8601),
            :updated_at => self.plan.operative_note.updated_at.to_formatted_s(:iso8601),
            :plan_id => self.plan.operative_note.plan_id,
            :diagnostic => self.plan.operative_note.diagnostic
          }
        end

        parsedPlan = {
          :id => self.plan.id,
          :description => self.plan.description,
          :emergency => self.plan.emergency,
          :created_at => self.plan.created_at.to_formatted_s(:iso8601),
          :updated_at => self.plan.updated_at.to_formatted_s(:iso8601),
          :consultation_id => self.plan.consultation_id,
          :operative_note => parsedOperativeNote,
          :procedures => self.plan.procedures
        }
      end
      # set de examenes fisicos
      parsedPhysicalExams = Array.new
      self.physical_exams.each do |pe|
        parsedPE = {
          :id => pe.id,
          :exam_type => pe.type_es,
          :url => pe.url,
          :observation => pe.observation,
          :created_at => pe.created_at.to_formatted_s(:iso8601),
          :updated_at => pe.updated_at.to_formatted_s(:iso8601),
          :consultation_id => pe.consultation_id
        }
        parsedPhysicalExams << parsedPE
      end
      # set de diagnosticos
      parsedDiagnostics = Array.new
      self.diagnostics.each do |dx|
        parsedDX = {
          :id => dx.id,
          :description => dx.description,
          :created_at => dx.created_at.to_formatted_s(:iso8601),
          :updated_at => dx.updated_at.to_formatted_s(:iso8601)
        }
        parsedDiagnostics << parsedDX
      end

      parsedConsultation = {
        :affliction => self.affliction,
        :created_at => self.created_at.to_formatted_s(:iso8601),
        :diagnostics => parsedDiagnostics,
        :evolution => self.evolution,
        :height => self.height,
        :id => self.id,
        :medical_record_id => self.medical_record_id,
        :note => self.note,
        :physical_exams => parsedPhysicalExams,
        :plan => parsedPlan,
        :pressure_s => self.pressure_s,
        :pressure_d => self.pressure_d,
        :reason => self.reason,
        :updated_at => self.updated_at.to_formatted_s(:iso8601),
        :weight => self.weight
      }
  end

end
