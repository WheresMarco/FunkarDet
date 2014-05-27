require 'spec_helper'

describe "Adding group dates" do
  let(:user) { group.user }
  let!(:group) { create(:group) }
  before { sign_in user, password: 'treehouse1' }

  it "is successful with valid name" do
    visit_group_dates(group)
    create_group_date name: "Testdate"

    expect(page).to have_content("Added date.")

    expect(page).to have_content("Testdate")
  end

  it "displays an error with no name" do
    visit_group_dates(group)
    create_group_date name: ""

    within("div.flash") do
      expect(page).to have_content("Threre was a problem adding that date.")
    end

    expect(page).to have_content("can't be blank")
  end

  it "displays an error with a name less then 2 characters long" do
    visit_group_dates(group)
    create_group_date name: "1"

    within("div.flash") do
      expect(page).to have_content("Threre was a problem adding that date.")
    end

    expect(page).to have_content("is too short")
  end

  it "displays an error with no place" do
    visit_group_dates(group)
    create_group_date place: ""

    within("div.flash") do
      expect(page).to have_content("Threre was a problem adding that date.")
    end

    expect(page).to have_content("can't be blank")
  end

  it "displays an error with no place less then 2 characters long" do
    visit_group_dates(group)
    create_group_date place: "1"

    within("div.flash") do
      expect(page).to have_content("Threre was a problem adding that date.")
    end

    expect(page).to have_content("is too short")
  end
end
