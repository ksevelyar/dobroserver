require 'spec_helper'

feature "Posts" do
  feature "GET /posts" do
    scenario "works! (now write some real specs)" do
      visit posts_path
      page.should have_content("Dobroserver")
    end
  end
end
