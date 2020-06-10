require 'rails_helper'

RSpec.feature 'ShowWorkHistories', type: :feature do

  context 'when use is not logged in' do
    it 'must redirect to sign_in page' do
      visit 'work_histories/'

      expect(page).to_not have_content('Cadastro de apontamento de trabalho')
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context 'when user is logged in' do
    let(:user) { create(:user) }

    before(:each) do
      create(:work_history, user: user, work_history_type: 'entrance', instant_date: Time.zone.now.strftime('%d/%m/%Y'), instant_time: Time.zone.now.strftime('%H:%M/%S'))
      create(:work_history, user: user, work_history_type: 'end_day',  instant_date: Time.zone.now.strftime('%d/%m/%Y'), instant_time: Time.zone.now.strftime('%H:%M/%S'))
      create(:work_history, user: user, work_history_type: 'entrance', instant_date: (Time.zone.now + 1.day).strftime('%d/%m/%Y'), instant_time: Time.zone.now.strftime('%H:%M/%S'))
      create(:work_history, user: user, work_history_type: 'entrance', instant_date: (Time.zone.now - 1.day).strftime('%d/%m/%Y'), instant_time: Time.zone.now.strftime('%H:%M/%S'))

      visit '/users/sign_in'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

      click_button 'Login'
    end

    context 'not filtering by today only' do
      it 'must show all the work histories' do
        click_link 'Meus apontamentos'

        expect(page).to have_selector('tr', count: 5)
        expect(page).to have_content('Entrada/inicio do trabalho', count: 3)
        expect(page).to have_content('Encerramento/saída do trabalho', count: 1)
      end
    end
    
    context 'filtering by today' do
      it 'must show only the work_history from today' do
        click_link 'Meus apontamentos'
        click_link 'Filtrar por apontamentos de hoje'

        expect(page).to have_selector('tr', count: 3)
        expect(page).to have_content('Entrada/inicio do trabalho', count: 1)
        expect(page).to have_content('Encerramento/saída do trabalho', count: 1)
      end
    end
  end
end
