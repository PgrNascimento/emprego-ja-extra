FactoryGirl.define do
  factory :job do
    title "Vaga de Desenvolvedor"
    category
    company
    description "Vaga legal"
    location "Em casa"
    created_at Time.now
  end
end
