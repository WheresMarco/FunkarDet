require 'spec_helper'

describe Group do
  context "relationships" do
    it { should have_many(:group_dates) }
    it { should have_many(:group_members) }
    it { should belong_to(:user) }
  end
end
