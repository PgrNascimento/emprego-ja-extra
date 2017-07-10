require 'rails_helper'

feature 'User create jobs' do
  let(:user) { login }
  before { user }
  scenario 'successfully' do
    company = create(:company, name: 'Campus Code')
    category = create(:category, name: 'Testers')

    visit new_job_path
    fill_in 'Título',       with: 'Vaga de Dev'
    select 'CLT',           from: 'Tipo de Contratação'
    fill_in 'Local',        with: 'São Paulo'
    select  category.name,  from: 'Categoria'
    select  company.name,   from: 'Empresa'
    fill_in 'Descrição',    with: 'Precisa deixar tudo verde'
    click_on 'Criar Vaga'

    expect(page).to have_css('h1', text: 'Vaga de Dev')
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'CLT'
    expect(page).to have_content 'Testers'
    expect(page).to have_content 'Campus Code'
    expect(page).to have_content 'Precisa deixar tudo verde'
  end

  scenario 'and mark as featured' do
    company = create(:company, name: 'Campus Code')
    category = create(:category, name: 'Testers')

    visit new_job_path
    fill_in 'Título',       with: 'Vaga de Dev'
    select 'CLT',           from: 'Tipo de Contratação'
    fill_in 'Local',        with: 'São Paulo'
    select  category.name,  from: 'Categoria'
    select  company.name,   from: 'Empresa'
    fill_in 'Descrição',    with: 'Precisa deixar tudo verde'
    check 'Destaque'
    click_on 'Criar Vaga'

    expect(page).to have_css('h1', text: 'Vaga de Dev')
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'CLT'
    expect(page).to have_content 'Testers'
    expect(page).to have_content 'Campus Code'
    expect(page).to have_content 'Precisa deixar tudo verde'
    expect(page).to have_css('strong', text: 'Destaque')
  end

  scenario 'and should fill all fields' do
    visit new_job_path

    click_on 'Criar Vaga'

    expect(page).to have_content 'Não foi possível criar a vaga'
  end

  scenario 'and view only his companies' do
    another_user = create(:user)
    create(:company, name: 'Campus Code', user: user)
    create(:company, name: 'Google', user: another_user)
    create(:category, name: 'Testers')

    visit new_job_path

    within('select#job_company_id') do
      expect(page).to have_css('option', text: 'Campus Code')
      expect(page).not_to have_css('option', text: 'Google')
    end
  end
end
