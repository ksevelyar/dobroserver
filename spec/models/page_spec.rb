require 'spec_helper'

describe Page do
  it_behaves_like "BlogRecord"
  subject { create :page, title: "Страница" }

  its(:content) { should eq "content" }
  its(:slug) { should eq "stranitsa" }
end
