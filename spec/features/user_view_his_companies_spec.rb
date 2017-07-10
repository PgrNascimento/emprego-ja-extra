require 'rails_helper'

feature 'User view his jobs' do
  let(:user) { login }
  before { user }
  scenario 'successfully' do
    create(:company, name: 'Campus Code', user: user)
    create(:company, name: 'Google', user: user)

    visit root_path
    click_on 'Minhas Empresas'

    expect(current_path).to eq my_companies_path
    expect(page).to have_css('h2', text: 'Campus Code')
    expect(page).to have_link('Campus Code')
    expect(page).to have_css('h2', text: 'Google')
    expect(page).to have_link('Google')
  end

  scenario 'and view only his jobs' do
    another_user = create(:user)
    create(:company, name: 'Campus Code', user: user)
    create(:company, name: 'Google', user: another_user)

    visit root_path
    click_on 'Minhas Empresas'

    expect(current_path).to eq my_companies_path
    expect(page).to have_css('h2', text: 'Campus Code')
    expect(page).to have_link('Campus Code')
    expect(page).not_to have_link('Google')
  end

  scenario 'and view a friendly message' do
    visit my_companies_path

    expect(page).to have_content('Nenhuma empresa encontrada')
  end
end
