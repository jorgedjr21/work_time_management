require 'rails_helper'

RSpec.feature 'RegisterUsers', type: :feature do

  describe 'Registering new user' do
    it 'must visit the new user page' do
      visit '/'
      click_link 'Cadastro de usuário'
      expect(page).to have_content('Cadastro de Usuários')
    end

    context 'filling form correcty' do
      it 'must create a new user' do
        visit '/'
        click_link 'Cadastro de usuário'

        fill_in 'user_name', with: 'User name'
        fill_in 'user_email', with: 'email@test.com'
        fill_in 'user_password', with: '1234567'
        fill_in 'user_password_confirmation', with: '1234567'

        click_button 'Cadastrar'

        expect(page).to have_content('Parabéns, seu cadastro foi realizado com sucesso.')
        expect(page).to have_current_path(root_path)
      end
    end

    context 'filling form incorrectly' do
      before(:each) do
        visit '/'
        click_link 'Cadastro de usuário'
      end

      it 'with wrong name' do

        fill_in 'user_name', with: ''
        fill_in 'user_email', with: 'email@test.com'
        fill_in 'user_password', with: '1234567'
        fill_in 'user_password_confirmation', with: '1234567'

        click_button 'Cadastrar'

        expect(page).to have_content('Nome não pode ficar em branco')
        expect(page).to have_content('Alguns problemas foram encontrados, por favor, verifique abaixo:')
        expect(page).to have_current_path(user_registration_path)
      end

      it 'with wrong email' do
        emails = ['', 'teste', 'teste@']

        fill_in 'user_name', with: 'Nome'
        fill_in 'user_email', with: emails.sample
        fill_in 'user_password', with: '1234567'
        fill_in 'user_password_confirmation', with: '1234567'

        click_button 'Cadastrar'

        email_input = page.find_by_id('user_email')
        expect(page).to have_content('Alguns problemas foram encontrados, por favor, verifique abaixo:')
        expect(email_input[:class].include?('is-invalid')).to be_truthy
        expect(page).to have_current_path(user_registration_path)
      end

      it 'with wrong password' do
        password = ['', 'teste'].sample

        fill_in 'user_name', with: 'Nome'
        fill_in 'user_email', with: 'teste@email.com'
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password

        click_button 'Cadastrar'

        passoword_input = page.find_by_id('user_password')

        expect(page).to have_content('Alguns problemas foram encontrados, por favor, verifique abaixo:')
        expect(passoword_input[:class].include?('is-invalid')).to be_truthy
        expect(page).to have_current_path(user_registration_path)
      end

      it 'with wrong password confirmation' do
        password = ['', 'teste'].sample

        fill_in 'user_name', with: 'Nome'
        fill_in 'user_email', with: 'teste@email.com'
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: 'other password'

        click_button 'Cadastrar'

        passoword_confirmation_input = page.find_by_id('user_password_confirmation')

        expect(page).to have_content('Alguns problemas foram encontrados, por favor, verifique abaixo:')
        expect(passoword_confirmation_input[:class].include?('is-invalid')).to be_truthy
        expect(page).to have_current_path(user_registration_path)
      end
    end
  end
end
