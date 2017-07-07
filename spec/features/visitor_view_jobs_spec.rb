require 'rails_helper'

feature 'Visitor view jobs on home page' do
  scenario 'successfully' do
    company = create(:company, name: 'Campus Code')
    create(:job, title: 'Vaga de Dev', company: company, location: 'São Paulo')

    visit root_path

    expect(page).to have_link('Vaga de Dev')
    expect(page).to have_content('Campus Code')
    expect(page).to have_content('São Paulo')
    expect(page).not_to have_content('Destaque')
  end

  scenario 'and view a list of jobs' do
    company = create(:company, name: 'Campus Code')
    job = create(:job, title: 'Vaga de Dev', company: company, location: 'São Paulo')
    another_job = create(:job, title: 'UX Senior', company: company, location: 'São Paulo', featured: true)

    visit root_path

    within("div#job_#{job.id}") do
      expect(page).to have_css('h2',text: job.title)
      expect(page).to have_link(job.title)
      expect(page).to have_content(job.company.name)
      expect(page).not_to have_content(job.description)
    end

    within("div#job_#{another_job.id}") do
      expect(page).to have_css('h2',text: another_job.title)
      expect(page).to have_link(another_job.title)
      expect(page).to have_content(another_job.company.name)
      expect(page).to have_css('strong', text: 'Destaque')
      expect(page).not_to have_content(another_job.description)
    end
  end
end
