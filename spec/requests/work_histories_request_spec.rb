require 'rails_helper'

RSpec.describe "WorkHistories", type: :request do
  describe 'Creating a new work history' do

    context 'when use is not logged in' do
      let(:params) do
        {
          work_history: {
            instant_date: Time.zone.now.strftime('%d/%m/%Y'),
            instant_time: Time.zone.now.strftime('%H/%M/%S'),
            work_history_type: WorkHistory.work_history_types.keys.sample
          }
        }
      end

      it 'must not create a new work_history' do
        expect { post '/work_histories', params: params }.not_to change(WorkHistory, :count)
      end

      it 'must redirect to sign_in page' do
        post '/work_histories', params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when use is logged in' do
      let(:user) { create(:user) }

      before(:each) do
        sign_in user
      end

      context 'with valid params' do
        let(:params) do
          {
            work_history:{
              instant_date: Time.zone.now.strftime('%d/%m/%Y'),
              instant_time: Time.zone.now.strftime('%H/%M/%S'),
              work_history_type: WorkHistory.work_history_types.keys.sample
            }
          }
        end

        it 'must create a new work history appointment' do
          expect { post '/work_histories', params: params }.to change(WorkHistory, :count).by(1)
        end

        it 'must redirect to root_path' do
          post '/work_histories', params: params

          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid attributes' do
        let(:params) do
          {
            work_history:{
              instant_date: '',
              instant_time: '',
              work_history_type: WorkHistory.work_history_types.keys.sample
            }
          }
        end

        it 'must not create a new work history appoitment' do
          expect { post '/work_histories', params: params }.not_to change(WorkHistory, :count)
        end
      end
    end
  end
end
