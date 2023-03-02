require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:name) }
  end

  describe 'association' do
    it { should have_many(:employees) }
  end
end
