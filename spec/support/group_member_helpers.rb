module GroupMemberHelpers
  def visit_group_members(group)
    visit "/groups"
    within dom_id_for(group) do
      click_link "List Members"
    end
  end

  def create_group_member(options={})
    options[:name] ||= "Testmember"
    options[:email] ||= "test@example.com"

    click_link "New Member"

    fill_in "Name", with: options[:name]
    fill_in "Email", with: options[:email]

    click_button "Save"
  end
end
