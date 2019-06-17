# frozen_string_literal: true

require 'translit'
require 'active_support/core_ext'

describe Translit do
  it 'returns valid slug for cyrillic title' do
    title = 'Съешь ещё этих мягких французских булок, да выпей чаю'
    slug  = 'sesh-eschyo-etih-myagkih-frantsuzskih-bulok-da-vyipey-chayu'

    expect(described_class.slug(title)).to eq slug
  end

  it 'returns valid slug for english title' do
    title = 'Quick fox jumps nightly above wizard'
    slug  = 'quick-fox-jumps-nightly-above-wizard'

    expect(described_class.slug(title)).to eq slug
  end
end
