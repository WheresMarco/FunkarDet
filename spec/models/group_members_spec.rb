require 'spec_helper'

describe GroupMember do
  it { should belong_to(:group) }
end
