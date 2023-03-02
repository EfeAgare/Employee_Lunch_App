require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:name) }
  end

  describe 'association' do
    it { should belong_to :department }
  end
end
