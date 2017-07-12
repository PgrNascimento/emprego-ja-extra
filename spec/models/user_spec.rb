require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#owner?' do
    let(:user) { create(:user) }
    context 'when user has one job' do
      it 'should be owner' do
        job = create(:job, user: user)
        expect(user.owner?(job)).to be_truthy
      end
    end

    context 'when user has many jobs' do
      it 'should be owner' do
        job = create(:job, user: user)
        other_job = create(:job, user: user)
        expect(user.owner?(job)).to be_truthy
        expect(user.owner?(other_job)).to be_truthy
      end
    end

    context 'when another user has job' do
      it 'should not be owner' do
        another_user = create(:user)
        job = create(:job, user: another_user)
        expect(user.owner?(job)).to be_falsy
      end
    end
  end
end
