module GroupHelpers
  def update_group(options={})
    options[:name] ||= "Testgroup"
    options[:creation_date] ||= Date.today
    group = options[:group]

    visit "/groups"
    click_link "Edit Group"

    fill_in "Name", with: options[:name]

    select_date(options[:creation_date], prefix: "group", from: :creation_date)

    click_button "Update Group"
  end
end
