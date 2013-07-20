FactoryGirl.define do
  factory :image do
    image File.open(File.join(Rails.root, '/spec/fixtures/files/british_vogue_1978_december_kim_alexis_chatelain_cover.jpg'))
  end
end
