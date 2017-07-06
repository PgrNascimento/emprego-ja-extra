require 'rails_helper'

RSpec.describe Job, :type => :model do
  it 'should be valid' do
    job = Job.create()
    expect(job).not_to be_valid
    expect(job.errors[:title]).to include('can\'t be blank')
    expect(job.errors[:location]).to include('can\'t be blank')
    expect(job.errors[:description]).to include('can\'t be blank')
    expect(job.errors[:category]).to include('can\'t be blank')
  end

  describe '#new?' do
    context 'has 0 days from created at' do
      it 'is new' do
        job = create(:job)
        expect(job).to be_new
      end
    end

    context 'has 3 days from created at' do
      it 'is new' do
        job = create(:job, created_at: 3.days.ago)
        expect(job).to be_new
      end
    end

    context 'has 5 days from created at' do
      it 'is new' do
        job = create(:job, created_at: 5.days.ago)
        expect(job).to be_new
      end
    end

    context 'has 6 days from created at' do
      it 'is new' do
        job = create(:job, created_at: 6.days.ago)
        expect(job).not_to be_new
      end
    end

    context 'has 10 days from created at' do
      it 'is new' do
        job = create(:job, created_at: 10.days.ago)
        expect(job).not_to be_new
      end
    end

    context 'has 40 days from created at' do
      it 'is new' do
        job = create(:job, created_at: 40.days.ago)
        expect(job).not_to be_new
      end
    end
  end

  describe '#expired?' do
    context 'has 10 days from created at date' do
      it 'is not expired' do
        job = create(:job, created_at: 10.days.ago)
        expect(job).to_not be_expired
      end
    end

    context 'has 60 days from created at date' do
      it 'is not expired' do
        job = create(:job, created_at: 60.days.ago)
        expect(job).to_not be_expired
      end
    end

    context 'has 90 days from created at date' do
      it 'is expired' do
        job = create(:job, created_at: 90.days.ago)
        expect(job).to be_expired
      end
    end

    context 'has 120 days from created at date' do
      it 'is expired' do
        job = create(:job, created_at: 120.days.ago)
        expect(job).to be_expired
      end
    end
  end
end
