require 'rails_helper'

RSpec.describe WorkHistory, type: :model do
  it { should belong_to(:user) }
  it { should have_db_index(:work_history_type) }
  it { should define_enum_for(:work_history_type).with_values(%i[entrance out_for_lunch lunch_arrival end_day])}
  it { is_expected.to validate_presence_of(:instant_date) }
  it { is_expected.to validate_presence_of(:instant_time) }

  context '#from_today' do
    let(:user) { create(:user) }

    before(:each) do
      create_list(:work_history, 3, user: user, instant_date: Time.zone.now.strftime('%d/%m/%Y'), instant_time: Time.zone.now.strftime('%H:%M/%S'))
      create_list(:work_history, 3, user: user, instant_date: (Time.zone.now + 1.day).strftime('%d/%m/%Y'), instant_time: Time.zone.now.strftime('%H:%M/%S'))
      create_list(:work_history, 3, user: user, instant_date: (Time.zone.now - 1.day).strftime('%d/%m/%Y'), instant_time: Time.zone.now.strftime('%H:%M/%S'))
    end

    it 'should return the work history with instant as today' do
      expect(WorkHistory.from_today.count).to eq(3)
    end
  end
end
