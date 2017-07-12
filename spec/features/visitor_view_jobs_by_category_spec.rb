require 'rails_helper'

feature 'Visitor view jobs by category' do
  let(:user) { create(:user) }
  scenario 'successfully' do
    category = Category.create(name: 'Desenvolvedor Mobile', user: user)

    create(:job, category: category, title: 'Vaga de Designer')
    create(:job, category: category, title: 'Vaga de Dev')
    visit root_path

    click_on category.name

    expect(page).to have_css('h1', text: category.name)
    expect(page).to have_link('Vaga de Designer')
    expect(page).to have_link('Vaga de Dev')
  end

  scenario 'and view only the current category jobs' do
    category = Category.create(name: 'Desenvolvedor', user: user)
    another_category = Category.create(name: 'Analista QA', user: user)
    create(:job, category: category, title: 'Vaga de Dev')
    create(:job, category: another_category, title: 'Designer')

    visit root_path
    click_on another_category.name

    expect(page).to have_css('h1', text: another_category.name)
    expect(page).to have_link 'Designer'
    expect(page).not_to have_link 'Vaga de Dev'
  end

  scenario 'view a friendly empty message' do
    category = Category.create(name: 'Gerente', user: user)

    visit root_path
    click_on category.name

    expect(page).to have_content 'Nenhuma vaga disponível'
  end
end
