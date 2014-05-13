require 'spec_helper'

describe "Listing groups" do
  it "requires login" do
    visit "/groups"
    expect(page).to have_content("You must be logged in")
  end
end
