require 'rails_helper'

feature 'Visitor view jobs by company' do
  let(:user) { create(:user) }
  scenario 'successfully' do
    category = create(:category)
    category_ux = create(:category, name: 'Desenvolvedor')
    company = create(:company, name: 'Campus Code')
    create(:job, category: category, company: company, title: 'Vaga de Dev')
    create(:job, category: category_ux, company: company, title: 'Analista UX')

    visit root_path
    click_on 'Campus Code'

    expect(page).to have_css('h1', text: 'Campus Code')
    expect(page).to have_link('Vaga de Dev')
    expect(page).to have_content('Desenvolvedor')
    expect(page).to have_content('Analista UX')
    expect(page).to have_content('UX')
  end

  scenario 'and view only the company jobs' do
    company = create(:company, name: 'Campus Code')
    another_company = create(:company, name: 'Google')
    job = create(:job, company: company, title: 'Vaga de Dev')
    another_job = create(:job, company: another_company, title: 'Estagio')
    visit root_path
    click_on 'Google'

    expect(page).to have_css('h1', text: 'Google')

    expect(page).not_to have_content('Vaga de Dev')
    expect(page).to have_css("div#job_#{another_job.id}", text: 'Estagio')
    expect(page).not_to have_css("div#job_#{job.id}", text: job.category.name)
  end

  scenario 'view a friendly message' do
    company = create(:company)
    visit root_path

    click_on company.name

    expect(page).to have_content 'Nenhuma vaga disponível'
  end
end
