# frozen_string_literal: true

require 'rails_helper'

describe Tag do
  let(:tag) { Fabricate(:tag) }

  it { is_expected.to have_and_belong_to_many(:products) }

  it { is_expected.to validate_presence_of(:title) }

  it 'validates uniqueness of title' do
    tag.save!
    expect(tag).to validate_uniqueness_of(:title).case_insensitive
  end

  it 'has a valid fabricator' do
    expect(tag).to be_valid
  end

  it 'has a persistable fabricator' do
    expect { tag.save }.to change(described_class, :count).by 1
  end
end
