FactoryGirl.define do
  factory :attachment do
    attachment File.open(File.join(Rails.root, '/spec/fixtures/files/british_vogue_1978_december_kim_alexis_chatelain_cover.jpg'))
  end
end
