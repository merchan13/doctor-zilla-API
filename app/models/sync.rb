class Sync < ApplicationRecord

  def self.consultations
    last_sync = self.last.sync_date

    consultations = Consultation.where("updated_at > ?", last_sync)

    json = Array.new

    consultations.each do |c|
      parsedConsultation = {
        :affliction => c.affliction,
        :created_at => c.created_at.to_formatted_s(:iso8601),
        :diagnostic => c.diagnostic,
        :evolution => c.evolution,
        :height => c.height,
        :id => c.id,
        :medical_record_id => c.medical_record_id,
        :note => c.note,
        :plan => c.plan,
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

    records = MedicalRecord.where("updated_at > ?", last_sync)

    json = Array.new

    records.each do |r|
      parsedRecord = {
        :address => r.address,
        :attachments => r.attachments,
        :backgrounds => r.parsedBackgrounds,
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
