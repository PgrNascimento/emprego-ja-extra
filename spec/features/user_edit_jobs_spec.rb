require 'rails_helper'

feature 'User edit jobs' do
  let(:user) { login }
  before { user }
  scenario 'successfully' do
    company = create(:company, name: 'Campus Code', user: user)
    job = create(:job, company: company)

    visit edit_job_path(job)
    fill_in 'Título',       with: 'Dev Android'
    fill_in 'Local',        with: 'Belo Horizonte'
    fill_in 'Descrição',    with: 'Desenvolvedor de apps integradas via API'
    click_on 'Atualizar Vaga'

    save_page
    expect(page).to have_css('h1', text: 'Dev Android')
    expect(page).to have_content 'Belo Horizonte'
    expect(page).to have_content job.category.name
    expect(page).to have_content job.company.name
    expect(page).to have_content 'Desenvolvedor de apps integradas via API'
  end

  scenario 'and change company' do
    company = create(:company, name: 'Campus Code', user: user)
    create(:company, name: 'Google', user: user)
    job = create(:job, company: company)

    visit edit_job_path(job)
    select 'Google', from: 'Empresa'
    click_on 'Atualizar Vaga'

    expect(page).to have_css('h1', text: job.title)
    expect(page).to have_content 'Google'
    expect(page).not_to have_content 'Campus Code'
  end

  scenario 'with valid data' do
    job = create(:job)
    visit edit_job_path(job)

    fill_in 'Título', with: ''
    click_on 'Atualizar Vaga'

    expect(page).to have_content 'Não foi possível atualizar a vaga'
  end
end
