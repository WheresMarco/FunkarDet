require 'spec_helper'

describe GroupMembers do
  it { should belong_to(:group) }
end
