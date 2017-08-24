class Sync < ApplicationRecord

  def self.consultations
    last_sync = self.last.sync_date

    consultations = Consultation.joins(:physical_exams, plan: :operative_note).distinct
                                 .where('consultations.created_at > ? OR consultations.updated_at > ?
                                        OR physical_exams.created_at > ? OR physical_exams.updated_at > ?
                                        OR plans.created_at > ? OR plans.updated_at > ?
                                        OR operative_notes.created_at > ? OR operative_notes.updated_at > ?',
                                        last_sync,last_sync,last_sync,last_sync,last_sync,last_sync,last_sync,last_sync)

    json = Array.new

    consultations.each do |c|
      # set de plan
      parsedPlan = Hash.new
      if !c.plan.nil?
        parsedPlan = {
          :id => c.plan.id,
          :description => c.plan.description,
          :emergency => c.plan.emergency,
          :created_at => c.plan.created_at.to_formatted_s(:iso8601),
          :updated_at => c.plan.updated_at.to_formatted_s(:iso8601),
          :consultation_id => c.plan.consultation_id,
          :operative_note => c.plan.operative_note,
          :procedures => c.plan.procedures
        }
      end

      parsedConsultation = {
        :affliction => c.affliction,
        :created_at => c.created_at.to_formatted_s(:iso8601),
        :diagnostic => c.diagnostic,
        :evolution => c.evolution,
        :height => c.height,
        :id => c.id,
        :medical_record_id => c.medical_record_id,
        :note => c.note,
        :plan => parsedPlan,
        :pressure_s => c.pressure_s,
        :pressure_d => c.pressure_d,
        :reason => c.reason,
        :updated_at => c.updated_at.to_formatted_s(:iso8601),
        :weight => c.weight,
        :physical_exams => c.parsedPE
      }
      json << parsedConsultation
    end
    json
  end

  def self.medical_records
    last_sync = self.last.sync_date

    records = MedicalRecord.joins(:attachments, :reports).distinct
                           .where('medical_records.created_at > ? OR medical_records.updated_at > ?
                                  OR attachments.created_at > ? OR attachments.updated_at > ?
                                  OR reports.created_at > ? OR reports.updated_at > ?',
                                  last_sync,last_sync,last_sync,last_sync,last_sync,last_sync)

    json = Array.new

    records.each do |r|
      # set de antecedentes
      parsedBackgrounds = Array.new
      r.backgrounds.each do |b|
        parsedBg = {
          :background_type => b.type_es,
          :medical_record_id => b.medical_record_id,
          :created_at => b.created_at.to_formatted_s(:iso8601),
          :description => b.description,
          :id => b.id,
          :updated_at => b.updated_at.to_formatted_s(:iso8601)
        }
        parsedBackgrounds << parsedBg
      end
      # set de historia
      parsedRecord = {
        :address => r.address,
        :attachments => r.attachments,
        :backgrounds_new => parsedBackgrounds,
        :birthday => r.birthday,
        :cellphone_number => r.cellphone_number,
        :created_at => r.created_at.to_formatted_s(:iso8601),
        :document => r.document,
        :document_type => r.document_type,
        :email => r.email,
        :first_consultation_date => r.first_consultation_date.to_formatted_s(:iso8601),
        :gender => r.gender,
        :id => r.id,
        :insurance => r.insurance,
        :last_name => r.last_name,
        :name => r.name,
        :occupation => r.occupation,
        :phone_number => r.phone_number,
        :physic_data => r.physic_data,
        :profile_picture => r.profile_picture.url,
        :referred_by => r.referred_by,
        :reports => r.reports,
        :representative_document => r.representative_document,
        :updated_at => r.updated_at.to_formatted_s(:iso8601)
      }
      json << parsedRecord
    end
    json
  end

end
