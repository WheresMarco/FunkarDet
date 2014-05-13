require 'spec_helper'

  describe "Adding group dates" do
    let(:user) { group.user }
    let!(:group) { create(:group) }
    before { sign_in user, password: 'treehouse1' }

    it "is successful with valid name" do
      visit_group_members(group)
      create_group_member name: "Test"

      expect(page).to have_content("Added member.")

      within("ul.group_members") do
        expect(page).to have_content("Test")
      end
    end

    it "displays an error with no name" do
      visit_group_members(group)
      create_group_member name: ""

      within("div.flash") do
        expect(page).to have_content("Threre was a problem adding that member.")
      end

      expect(page).to have_content("Name can't be blank")
    end

    it "displays an error with a name less then 2 characters long" do
      visit_group_members(group)
      create_group_member name: "1"

      within("div.flash") do
        expect(page).to have_content("Threre was a problem adding that member.")
      end

      expect(page).to have_content("Name is too short")
    end

    it "displays an error with no email" do
      visit_group_members(group)
      create_group_member email: ""

      within("div.flash") do
        expect(page).to have_content("Threre was a problem adding that member.")
      end

      expect(page).to have_content("Email can't be blank")
    end

    it "displays an error with no place less then 2 characters long" do
      visit_group_members(group)
      create_group_member email: "1"

      within("div.flash") do
        expect(page).to have_content("Threre was a problem adding that member.")
      end

      expect(page).to have_content("Email is invalid")
    end
end
