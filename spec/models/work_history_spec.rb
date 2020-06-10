require 'rails_helper'

RSpec.describe WorkHistory, type: :model do
  it { should belong_to(:user) }
  it { should have_db_index(:work_history_type) }
  it { should define_enum_for(:work_history_type).with_values([:entrance, :out_for_lunch, :lunch_arrival, :end_day])}
  it { is_expected.to validate_presence_of(:instant) }
end
