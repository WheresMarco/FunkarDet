module Helpers
  def select_date_and_time(date, options = {})
    field = options[:prefix].to_s + "_".to_s + options[:from].to_s
    select date.strftime('%Y'), :from => "#{field}_1i" #year
    select date.strftime('%B'), :from => "#{field}_2i" #month
    select date.strftime('%-e'), :from => "#{field}_3i" #day
    select date.strftime('%H'), :from => "#{field}_4i" #hour
    select date.strftime('%M'), :from => "#{field}_5i" #minute
  end

  def select_date(date, options = {})
    field = options[:prefix].to_s + "_".to_s + options[:from].to_s
    select date.strftime('%Y'), :from => "#{field}_1i" #year
    select date.strftime('%B'), :from => "#{field}_2i" #month
    select date.strftime('%-e'), :from => "#{field}_3i" #day
  end
end
