# frozen_string_literal: true

require 'spec_helper'

describe Comment, type: :model do
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :blog_record_id }

  # Antispam
  # it { should validate_absence_of :subject }
  # it { should validate_absence_of :nickname }

  it { is_expected.to allow_value('ksevelyar@domain.com').for(:email) }
  it { is_expected.not_to allow_value('ksevelyar@domain').for(:email) }

  it { is_expected.to belong_to :post }

  describe '#hot' do
    it 'returns true for new comments' do
      post = create :post
      comment = create :comment, post: post

      expect(comment.hot?).to be_truthy
    end

    it 'returns false for old comments' do
      post = create :post
      comment = create :comment, post: post, created_at: Time.now - 40.minutes

      expect(comment.hot?).to be_falsey
    end
  end

  describe 'sanitize' do
    pending
  end
end
