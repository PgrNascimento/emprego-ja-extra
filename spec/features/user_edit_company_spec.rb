require 'rails_helper'

feature 'User edit company' do
  scenario 'successfully' do
    company = create(:company)

    visit company_path(company)

    click_on "Editar"

    fill_in 'Nome',       with: 'Campus'
    fill_in 'Local',        with: 'São Paulo'
    fill_in 'Email',    with: 'campus@campuscode.com'
    fill_in 'Telefone', with: "11951342149"

    click_on 'Atualizar Empresa'

    expect(page).to have_css('h1', text: 'Campus')
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'campus@campuscode.com'
    expect(page).to have_content '11951342149'
  end

  scenario 'with valid data' do
    company = create(:company)

    visit edit_company_path(company)

    fill_in 'Nome', with: ''

    click_on 'Atualizar Empresa'

    expect(page).to have_content 'Não foi possível atualizar a empresa'
  end
end
