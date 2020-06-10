require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the WorkHistoriesHelper. For example:
#
# describe WorkHistoriesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe WorkHistoriesHelper, type: :helper do
  let(:work_history) { create(:work_history) }

  describe '#work_history_table_header' do
    context 'when no work history is passed' do
      it 'must return an empty array' do
        expect(helper.work_history_table_header(nil)).to eq([])
      end
    end

    context 'when work history is passed' do
      it 'should return the accepted table headers' do
        expect(helper.work_history_table_header(work_history)).to eq(['work_history_type', 'instant'])
      end
    end
  end
end
