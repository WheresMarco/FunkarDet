module GroupHelpers
  def update_group(options={})
    options[:name] ||= "Testgroup"
    options[:creation_date] ||= Date.today
    group = options[:group]

    visit "/groups"
    click_link "Edit group"

    fill_in "Groupname", with: options[:name]

    click_button "Save"
  end
end
