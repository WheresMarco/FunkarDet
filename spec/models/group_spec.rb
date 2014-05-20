require 'spec_helper'

describe Group do
  context "relationships" do
    it { should have_many(:group_dates) }
    it { should have_many(:group_members) }
    it { should have_and_belong_to_many(:user) }
  end
end
