require "rails_helper"

RSpec.describe Job, :type => :model do
  before do
    @job = create(:job, title: "Vaga de Design")
    @expired_job = create(:job, title:"Vaga de Dev", created_at: -90.days.from_now)
  end
  it 'should be valid' do
    job = Job.create()
    expect(job).not_to be_valid
    expect(job.errors[:title]).to include("can't be blank")
    expect(job.errors[:location]).to include("can't be blank")
    expect(job.errors[:description]).to include("can't be blank")
    expect(job.errors[:category]).to include("can't be blank")
  end

  describe "#expired?" do
    context "has 10 days from created at date" do
      it "is not expired" do
        expect(@job).to_not be_expired
      end
    end

    context "has 60 days from created at date" do
      it "is not expired" do
        expect(@job).to_not be_expired
      end
    end

    context "has 90 days from created at date" do
      it "is expired" do
        expect(@expired_job).to be_expired
      end
    end

    context "has 120 days from created at date" do
      it "is expired" do
        expect(@expired_job).to be_expired
      end
    end
  end
end
