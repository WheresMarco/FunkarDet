module GroupHelpers
  def update_group(options={})
    options[:name] ||= "Testgroup"
    group = options[:group]

    visit "/groups"
    within dom_id_for(group) do
      click_link "Edit"
    end

    fill_in "Name", with: options[:name]

    select "2012", from: "group[creation_date(1i)]"
    select "February", from: "group[creation_date(2i)]"
    select "22", from: "group[creation_date(3i)]"

    click_button "Update Group"
  end
end
