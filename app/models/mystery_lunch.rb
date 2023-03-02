class MysteryLunch < ApplicationRecord
  has_many :mystery_lunch_partners, dependent: :destroy
  has_many :employees, through: :mystery_lunch_partners


  scope :created_between, -> { 
    where('date(mystery_lunches.created_at) BETWEEN ? AND ?', 
    present_month.first, present_month.last) 
  }

  # Select new mystery partners on the 1st of each month
  def self.select_new_partners
    # Get all enabled employees
    enabled_employees = Employee.active

    # Get employees who were already partners in the last 3 months
    excluded_employees = get_excluded_employees

    # Exclude those employees from the list of enabled employees
    eligible_employees = enabled_employees.where.not(id: excluded_employees)

    # Shuffle the list of eligible employees and group them into pairs
    pairs = eligible_employees.shuffle.each_slice(2).to_a

    # If there is an odd number of eligible employees, add the last one to an existing pair
    if eligible_employees.count.odd?
      remaining_employee = pairs.pop.last
      add_remaining_employee_to_pair(pairs, remaining_employee)
    end

    # Create a new mystery lunch for each pair
    pairs.each do |pair|
      mystery_lunch = MysteryLunch.create
      pair.each do |employee|
         MysteryLunchPartner.create(employee: employee, mystery_lunch: mystery_lunch)
      end
    end
  end

  private

  # Get the list of employees who were partners in the last 3 months
  def self.get_excluded_employees
    last_three_months = Date.today.prev_month(3)..Date.today
    excluded_employees = []
    MysteryLunch.where(created_at: last_three_months).each do |mystery_lunch|
      excluded_employees += mystery_lunch.employees.map(&:id)
    end
    excluded_employees.uniq
  end

  # Add the remaining employee to an existing pair, making sure their departments are different
  def self.add_remaining_employee_to_pair(pairs, remaining_employee)
    pairs.each do |pair|
       if add_to_pair?(pair, remaining_employee)
          pair << remaining_employee
        break
       end
    end
  end

  def self.add_to_pair?(pair, remaining_employee)
    pair.count == 2 && pair[0].department != pair[1].department && 
        remaining_employee.department != pair[0].department && 
        remaining_employee.department != pair[1].department
  end

  def self.present_month
    Date.today.beginning_of_month..Date.today
  end
end
