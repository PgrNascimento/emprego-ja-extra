require 'rails_helper'

feature 'Visitor sign in' do
  scenario 'succesfully' do
    User.create(email: 'alan@teste.com', password: 'alanalan')

    visit root_path

    click_on 'Login'
    fill_in 'Email', with: 'alan@teste.com'
    fill_in 'Senha', with: 'alanalan'
    click_on 'Entrar'

    expect(current_path).to eq root_path
    expect(page).not_to have_link('Login')
    expect(page).to have_content('Bem vindo, alan@teste.com')
  end

  scenario 'and fill incorrect data' do
    User.create(email: 'alan@teste.com', password: 'alanalan')

    visit root_path

    click_on 'Login'
    fill_in 'Email', with: 'alan@teste.com'
    fill_in 'Senha', with: 'alanala'
    click_on 'Entrar'

    expect(current_path).to eq new_user_session_path
    expect(page).to have_link('Login')
    expect(page).not_to have_content('Bem vindo, alan@teste.com')
  end
end
