FactoryGirl.define do
  factory :attachment do
    medical_record
    url { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'attachments', 'test.png')) }
    description { Faker::ChuckNorris.fact }
  end
end
