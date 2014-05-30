module GroupMemberHelpers
  def visit_group_members(group)
    visit "/groups"
  end

  def create_group_member(options={})
    options[:name] ||= "Testmember"
    options[:email] ||= "test@example.com"

    click_link "New member"

    fill_in "Name", with: options[:name]
    fill_in "Email", with: options[:email]

    click_button "Add member"
  end
end
