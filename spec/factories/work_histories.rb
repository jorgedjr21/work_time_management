FactoryBot.define do
  factory :work_history do
    association :user
    work_history_type { 1 }
    instant_date { '10/06/2020'}
    instant_time { '15:00' }
    instant { '2020-06-10 00:45:46' }
  end
end
