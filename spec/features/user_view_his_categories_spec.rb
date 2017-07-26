require 'rails_helper'

feature 'User view his jobs' do
  let(:user) { login }
  before { user }
  scenario 'successfully' do
    create(:category, name: 'Desenvolvedor', user: user)
    create(:category, name: 'Analista', user: user)

    visit root_path
    click_on 'Minhas Categorias'

    expect(current_path).to eq my_categories_path
    expect(page).to have_css('h2', text: 'Desenvolvedor')
    expect(page).to have_link('Desenvolvedor')
    expect(page).to have_css('h2', text: 'Analista')
    expect(page).to have_link('Analista')
  end
end
