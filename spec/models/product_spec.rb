# frozen_string_literal: true

require 'rails_helper'

describe Product do
  let(:product) { Fabricate(:product) }

  it { is_expected.to have_and_belong_to_many(:tags) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_numericality_of(:price) }

  it 'validates uniqueness of name' do
    product.save!
    expect(product).to validate_uniqueness_of(:name).case_insensitive
  end

  it 'has a valid fabricator' do
    expect(product).to be_valid
  end

  it 'has a persistable fabricator' do
    expect { product.save }.to change(described_class, :count).by 1
  end
end
