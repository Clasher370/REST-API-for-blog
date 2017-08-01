require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:author) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  describe '#set_published_at' do
    let(:user) { create(:user) }

    context 'value not set' do
      let(:post) { create(:post, author_id: user.id) }

      it { expect(post.published_at.day).to eq Time.now.day }
    end

    context 'value is set' do
      let(:post) { create(:post, author_id: user.id, published_at: 2.month.ago) }

      it { expect(post.published_at.month).to eq 2.month.ago.month }
    end
  end
end
