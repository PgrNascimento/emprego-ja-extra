FactoryGirl.define do
  factory :job do
    title 'Vaga de Desenvolvedor'
    user
    category
    company
    description 'Vaga legal'
    location 'Em casa'
    hiring_type 'CLT'
    created_at Time.zone.now
  end
end
