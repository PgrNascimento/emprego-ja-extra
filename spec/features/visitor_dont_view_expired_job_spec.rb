require 'rails_helper'

feature 'Visitor view jobs on home page and dont view expired job' do
  scenario 'successfully' do
    job = create(:job, title: 'Vaga de Design')
    expired_job = create(:job, title: 'Vaga de Dev', created_at: 90.days.ago)

    visit root_path

    expect(page).to have_content(job.title)
    expect(page).not_to have_content(expired_job.title)
  end

  scenario 'and view a danger message' do
    expired_job = create(:job, title: 'Vaga de Dev', created_at: 90.days.ago)

    visit job_path(expired_job)

    expect(page).to have_css('.alert.alert-danger', text: 'Vaga expirada')
  end
end
