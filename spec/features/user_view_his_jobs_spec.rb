require 'rails_helper'

feature 'User view his jobs' do
  let(:user) { login }
  before { user }
  scenario 'successfully' do
    create(:job, title: 'Vaga de Dev', user: user)
    create(:job, title: 'Analista de Sistemas', user: user)

    visit root_path
    click_on 'Minhas Vagas'

    expect(current_path).to eq my_jobs_path
    expect(page).to have_css('h2', text: 'Vaga de Dev')
    expect(page).to have_css('h2', text: 'Analista de Sistemas')
    expect(page).to have_link('Vaga de Dev')
    expect(page).to have_link('Analista de Sistemas')
  end

  scenario 'and view only his jobs' do
    another_user = create(:user)
    create(:job, title: 'Vaga de Dev', user: user)
    create(:job, title: 'Analista de Sistemas', user: another_user)

    visit root_path
    click_on 'Minhas Vagas'

    expect(current_path).to eq my_jobs_path
    expect(page).to have_css('h2', text: 'Vaga de Dev')
    expect(page).not_to have_css('h2', text: 'Analista de Sistemas')
  end

  scenario 'and view a friendly message' do
    visit my_jobs_path

    expect(page).to have_content('Nenhuma vaga encontrada')
  end
end
