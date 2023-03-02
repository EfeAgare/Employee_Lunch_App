require 'rails_helper'

RSpec.describe MysteryLunchPartner, type: :model do
  describe 'association' do
    it { should belong_to(:employee) }
    it { should belong_to(:mystery_lunch) }
  end
end
