module GroupMemberHelpers
  def visit_group_members(group)
    visit "/groups"
    within dom_id_for(group) do
      click_link "List Members"
    end
  end

  def create_group_member(options={})
    options[:name] ||= "Testdate"
    options[:place] ||= "Placetest"
    options[:from_date] ||= DateTime.now
    options[:to_date] ||= DateTime.now
    options[:description] ||= "A sample text"

    click_link "New Group Date"

    fill_in "Name", with: options[:name]
    fill_in "Place", with: options[:place]

    select_date_and_time(options[:from_date], prefix: "group_date", from: :from_date)
    select_date_and_time(options[:to_date], prefix: "group_date", from: :to_date)

    fill_in "Description", with: options[:description]

    click_button "Save"
  end
end
