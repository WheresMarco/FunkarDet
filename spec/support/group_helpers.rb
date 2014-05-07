module GroupHelpers
  def create_group(options={})
    options[:name] ||= "Testgroup"
    options[:creation_date] ||= Date.today

    visit "/groups"
    click_link "New Group"
    expect(page).to have_content("New group")

    fill_in "Name", with: options[:name]

    select_date(options[:creation_date], prefix: "group", from: :creation_date)

    click_button "Create Group"
  end

  def update_group(options={})
    options[:name] ||= "Testgroup"
    options[:creation_date] ||= Date.today
    group = options[:group]

    visit "/groups"
    within dom_id_for(group) do
      click_link "Edit"
    end

    fill_in "Name", with: options[:name]

    select_date(options[:creation_date], prefix: "group", from: :creation_date)

    click_button "Update Group"
  end
end
