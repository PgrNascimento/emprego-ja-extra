require 'rails_helper'

feature 'User create companies' do
  let(:user) { login }
  scenario 'successfully' do
    company = Company.new(name: 'Campus Code',
                          location: 'São Paulo',
                          mail: 'contato@campus.com.br',
                          phone: '2369-3476',
                          user: user)

    visit new_company_path
    fill_in 'Nome',      with: company.name
    fill_in 'Local',     with: company.location
    fill_in 'Email',     with: company.mail
    fill_in 'Telefone',  with: company.phone

    click_on 'Criar Empresa'

    expect(page).not_to have_xpath("//img[contains(@src,'estrela')]")
    expect(page).to have_css('h1', text: company.name)
    expect(page).to have_content(company.location)
    expect(page).to have_content(company.mail)
    expect(page).to have_content(company.phone)
  end

  scenario 'and should fill all fields' do
    user

    visit new_company_path
    click_on 'Criar Empresa'

    expect(page).to have_content 'Não foi possível criar a empresa'
  end

  scenario 'and not access without signed in' do
    visit root_path
    click_on 'Nova Empresa'

    expect(current_path).to eq new_user_session_path
  end
end
