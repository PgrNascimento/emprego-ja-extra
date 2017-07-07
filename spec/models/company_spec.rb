require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { create(:company) }

  describe "#premium?" do
    context "has zero jobs" do
      it "is not premium" do
        expect(company).to_not be_premium
      end
    end

    context "has 4 jobs" do
      it "is not premium" do
        create_list(:job, 4, company: company)
        expect(company).to_not be_premium
      end
    end

    context "has 5 jobs" do
      it "is premium" do
        create_list(:job, 5, company: company)
        expect(company).to be_premium
      end
    end

    context "has 10 jobs" do
      it "is premium" do
        create_list(:job, 5, company: company)
        expect(company).to be_premium
      end
    end
  end
end
