module GroupDateHelpers
  def visit_group_dates(group)
    visit "/groups"
  end

  def create_group_date(options={})
    options[:name] ||= "Testdate"
    options[:place] ||= "Placetest"
    options[:from_date] ||= DateTime.now
    options[:to_date] ||= DateTime.now
    options[:description] ||= "A sample text"

    click_link I18n.t('layout.navigation.new-date')

    fill_in I18n.t('new-date.new-box.name'), with: options[:name]
    fill_in I18n.t('new-date.new-box.place'), with: options[:place]

    select_date_and_time(options[:from_date], prefix: "group_date", from: :from_date)
    select_date_and_time(options[:to_date], prefix: "group_date", from: :to_date)

    fill_in I18n.t('new-date.new-box.description'), with: options[:description]

    click_button I18n.t('new-date.new-box.submit')
  end
end
