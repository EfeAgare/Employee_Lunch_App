require 'rails_helper'

RSpec.describe MysteryLunch, type: :model do
  describe 'association' do
    it { should have_many(:mystery_lunch_partners) }
  end

  describe 'select_new_partners' do
    context 'When an employee is created' do
      context 'and no MysteryLunch exist' do
        
        it 'users join MysteryLunch partner only when select_new_partners is called' do
          expect(MysteryLunch.first).to be_nil

          run_seed

          MysteryLunch.select_new_partners

          expect(MysteryLunch.count).to eq 4
        end
      end

      context 'and MysteryLunch exist and a new employee is created' do
        it 'join an already existing MysteryLunch' do

          run_seed

          MysteryLunch.select_new_partners

          expect(MysteryLunch.count).to eq 4

          Employee.create!(name: "Knowledge", department_id: Department.first.id )

          expect(MysteryLunch.count).to eq 4
        end
      end

      context 'and MysteryLunch exist and an employee is deleted' do
        
        it 'is reassigned to an already existing MysteryLunch' do

          run_seed

          MysteryLunch.select_new_partners

          expect(MysteryLunch.count).to eq 4

          Employee.first.destroy

          expect(MysteryLunch.count).to eq 3
        end
      end
    end
  end



  def run_seed
    [{department: "operations", name: "Efe"}, {department: "sales", name: "Ise"}, 
      {department: "marketing", name: "Oshe"}, {department: "risk", name: "Maureen"}, 
      {department: "management", name: "Grace"}, {department: "finance", 
      name: "Dapo"}, {department: "HR", name: "Coza"}, 
      {department: "development and data", name: "Debbie"}].each do |list|

      department = Department.create!(name: list[:department])
      Employee.create!(name: list[:name], department_id: department.id )
    end
  end
end
