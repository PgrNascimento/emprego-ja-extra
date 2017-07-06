require 'rails_helper'

feature 'User view new job flag of the last five days' do
  scenario 'successfully'  do
    job = create(:job, title: 'Vaga 1')
    other_job = create(:job, title: 'Vaga 2', created_at: 6.days.ago)

    visit root_path

    expect(page).to have_css("#job_#{job.id} strong", text: 'NOVA!')
    expect(page).not_to have_css("#job_#{other_job.id} strong", text: 'NOVA!')
  end
end
