require 'rails_helper'

feature 'User create categories' do
  let(:user) { login }
  before { user }
  scenario 'successfully' do
    category = build(:category, name: 'Desenvolvedor')

    visit new_category_path

    fill_in 'Nome', with: category.name

    click_on 'Criar Categoria'

    expect(page).to have_css('h1', text: category.name)
  end
  scenario 'and should fill all fields' do
    visit new_category_path

    click_on 'Criar Categoria'

    expect(page).to have_content 'Não foi possível criar a categoria'
  end
end
