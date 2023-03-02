class Employee < ApplicationRecord
  acts_as_paranoid

  belongs_to :department

  has_many :mystery_lunch_partners, dependent: :destroy
  has_many :mystery_lunches, through: :mystery_lunch_partners

  validates :name, presence: true

  scope :active, -> { where(deleted_at: nil) }
 
  after_create :assign_to_mystery_lunch
  after_destroy :reassign_mystery_lunch_partner

  private

  def assign_to_mystery_lunch
    # Find a mystery lunch with two open spots
    mystery_lunch = existing_mystery_slots
                                
    return if mystery_lunch.empty?

    add_employee_to_pair(mystery_lunch, self)
  end

  def reassign_mystery_lunch_partner
    mystery_lunch = single_existing_mystery_slots

    return if mystery_lunch.empty?

    old_employee = mystery_lunch.last.employees.first

    mystery_lunch.last.destroy

    mystery_lunch = existing_mystery_slots
                              
    return if mystery_lunch.empty?

    add_employee_to_pair(mystery_lunch, old_employee)
  end

  def add_employee_to_pair(pairs, new_employee)
    pairs.each do |pair|
       if can_pair?(pair.employees, new_employee)
         # Add the new/old employee to the mystery lunch
          MysteryLunchPartner.create(employee: new_employee, mystery_lunch: pair)
        break
       end
    end
  end

  def can_pair?(pair, new_employee)
    pair.count == 2 && pair[0].department != pair[1].department && 
        new_employee.department != pair[0].department && 
        new_employee.department != pair[1].department
  end


  def existing_mystery_slots
    MysteryLunch.joins(:mystery_lunch_partners).created_between
                                .group('mystery_lunches.id')
                                .having('count(mystery_lunch_partners.id) = 2')
                                .order('RANDOM()')
  end

  def single_existing_mystery_slots
    MysteryLunch.joins(:mystery_lunch_partners).created_between
                                .group('mystery_lunches.id')
                                .having('count(mystery_lunch_partners.id) = 1')
                                .order('RANDOM()')
  end
end


