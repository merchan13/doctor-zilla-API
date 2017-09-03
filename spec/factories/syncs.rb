FactoryGirl.define do
  factory :sync do
    description { 'Sync description!' }
    sync_date { Time.now }
  end
end
