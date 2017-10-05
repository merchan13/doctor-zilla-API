class MedicalRecord < ApplicationRecord
  mount_uploader :profile_picture, AvatarUploader

  # User Avatar Validation
  validates_integrity_of  :profile_picture
  validates_processing_of :profile_picture

  has_many :backgrounds
  has_many :consultations
  has_many :attachments
  has_many :reports

  belongs_to :user
  belongs_to :insurance, optional: true
  belongs_to :occupation, optional: true

  validates_presence_of :document,
                        :document_type,
                        :first_consultation_date,
                        :name,
                        :last_name,
                        :birthday,
                        :gender,
                        :phone_number,
                        :address,
                        :occupation,
                        :insurance,
                        :user_id

  validates :document, uniqueness: { scope: [:document_type, :user_id], case_sensitive: false }
  validates :old_record_number, uniqueness: { case_sensitive: false, allow_nil: true }

  def full_name
    return "#{name} #{last_name}".strip if (name || last_name)
    "Anonymous"
  end

  def full_id
    return "#{document_type}-#{document}".strip if (document_type || document)
  end

  def age
    if self.birthday.present?
      dob = self.birthday
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end
  end

  def parsedBackgrounds
    self.backgrounds.each do |b|
      b.background_type = b.type_es
    end
  end

  def complete_info
      # set de historia
      parsedRecord = {
        :address => self.address,
        :attachments => self.jsonAttachments, #custom json
        :backgrounds => self.jsonBackgrounds, #custom json
        :birthday => self.birthday,
        :cellphone_number => self.cellphone_number,
        :created_at => self.created_at.to_formatted_s(:iso8601),
        :document => self.document,
        :document_type => self.document_type,
        :email => self.email,
        :first_consultation_date => self.first_consultation_date.to_formatted_s(:iso8601),
        :gender => self.gender,
        :id => self.id,
        :important => self.important,
        :insurance => self.insurance,
        :last_name => self.last_name,
        :name => self.name,
        :occupation => self.occupation,
        :old_record_number => self.old_record_number,
        :phone_number => self.phone_number,
        :physic_data => self.physic_data,
        :profile_picture => self.profile_picture.url,
        :referred_by => self.referred_by,
        :reports => self.jsonReports, #custom json
        :representative_document => self.representative_document,
        :updated_at => self.updated_at.to_formatted_s(:iso8601)
      }
  end

  def jsonAttachments
    parsedAttachmentsJSON = Array.new

    self.attachments.each do |a|
      parsedAttach = {
        :medical_record_id => a.medical_record_id,
        :created_at => a.created_at.to_formatted_s(:iso8601),
        :description => a.description,
        :id => a.id,
        :updated_at => a.updated_at.to_formatted_s(:iso8601)
      }

      parsedAttachmentsJSON << parsedAttach
    end

    parsedAttachmentsJSON
  end

  def jsonBackgrounds
    parsedBackgroundsJSON = Array.new

    self.backgrounds.each do |b|
      parsedBg = {
        :background_type => b.type_es,
        :medical_record_id => b.medical_record_id,
        :created_at => b.created_at.to_formatted_s(:iso8601),
        :description => b.description,
        :id => b.id,
        :updated_at => b.updated_at.to_formatted_s(:iso8601)
      }

      parsedBackgroundsJSON << parsedBg
    end

    parsedBackgroundsJSON
  end

  def jsonReports
    parsedReportsJSON = Array.new

    self.reports.each do |r|
      parsedReport = {
        :report_type => r.report_type,
        :medical_record_id => r.medical_record_id,
        :created_at => r.created_at.to_formatted_s(:iso8601),
        :description => r.description,
        :id => r.id,
        :updated_at => r.updated_at.to_formatted_s(:iso8601)
      }

      parsedReportsJSON << parsedReport
    end

    parsedReportsJSON
  end

  def physic_data
    physics =  Hash.new
    physics = { "height" => 0, "weight" => 0, "pressure_d" => "?", "pressure_s" => "?"}

    self.consultations.each do |c|
      physics["height"] = c.height if c.height != nil
      physics["weight"] = c.weight if c.weight != nil
      physics["pressure_d"] = c.pressure_d if c.pressure_d != ""
      physics["pressure_s"] = c.pressure_s if c.pressure_s != ""
    end

    return physics
  end

  def update_background (type, description)
    bg = self.backgrounds.where(background_type: type).first
    if bg.nil?
      if description != ""
        self.backgrounds.create(background_type: type, description: description)
      end
    else
      if description == "" || description == " "
        bg.delete
      else
        bg.description = description
        bg.save
      end
    end
  end

  def imc
    if physic_data["weight"] != 0 && physic_data["height"] != 0
      imc = physic_data["weight"]/((physic_data["height"]/100) ** 2)
    else
      imc = 0
    end
  end

  def self.search(param)
    return MedicalRecord.none if param.blank?

    param.strip!
    param.downcase!
    (name_matches(param) + last_name_matches(param) + document_matches(param)).uniq
  end

  def self.name_matches(param)
    matches('name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.document_matches(param)
    matches('document', param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end

  private
    def self.numero_nuevo
      MedicalRecord.count + 1
    end

end
