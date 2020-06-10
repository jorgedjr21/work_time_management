require 'rails_helper'

RSpec.feature "ShowHomeInfos", type: :feature do
  describe 'accessing home page' do
    let(:user) { create(:user) }
    before(:each) do
      create_list(:work_history, 3, user: user, instant_date: Time.zone.now.strftime('%d/%m/%Y'), instant_time: Time.zone.now.strftime('%H:%M/%S'))
      create_list(:work_history, 3, user: user, instant_date: (Time.zone.now + 1.day).strftime('%d/%m/%Y'), instant_time: Time.zone.now.strftime('%H:%M/%S'))
      create_list(:work_history, 3, user: user, instant_date: (Time.zone.now - 1.day).strftime('%d/%m/%Y'), instant_time: Time.zone.now.strftime('%H:%M/%S'))
    end

    context 'logged in' do
      before(:each) do
        visit '/users/sign_in'
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password

        click_button 'Login'
      end


      it 'must show some user work_history infos' do
        visit '/'
        expect(page).to have_content('9')
        expect(page).to have_content('Seus apontamentos')
        expect(page).to have_content('3')
        expect(page).to have_content('Seus apontamentos hoje')
      end
    end

    context 'not logged in' do
      it 'must not show user work_history infos' do
        visit '/'
        expect(page).not_to have_content('Seus apontamentos')
        expect(page).not_to have_content('Seus apontamentos hoje')
      end
    end
  end
end
