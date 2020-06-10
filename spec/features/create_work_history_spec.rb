require 'rails_helper'

RSpec.feature 'CreateWorkHistories', type: :feature do
  describe 'Creating a new Work History' do
    context 'when use is not logged in' do
      it 'must redirect to sign_in page' do
        visit 'work_histories/new'

        expect(page).to_not have_content('Cadastro de apontamento de trabalho')
        expect(page).to have_current_path(new_user_session_path)
      end
    end

    context 'when user is logged_in' do
      let(:user) { create(:user) }

      before(:each) do
        visit '/users/sign_in'
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password

        click_button 'Login'
      end

      it 'must show the success message' do
        click_link 'Novo apontamento'
        find('#work_history_work_history_type').find("option[value=#{WorkHistory.work_history_types.keys.sample}]").select_option

        click_button 'Salvar'

        expect(page).to have_content('Apontamento de trabalho criado com sucesso!')
        expect(page).to have_current_path(root_path)
      end

      context 'when not filling the work_history_type' do
        it 'must show the error message' do
          click_link 'Novo apontamento'
          find('#work_history_work_history_type').find("option[value='']").select_option

          click_button 'Salvar'

          expect(page).to have_content('Tipo do apontamento não pode ficar em branco e Tipo do apontamento não está incluído na lista')
          expect(page).to have_current_path('/work_histories')
        end
      end
    end
  end
end
