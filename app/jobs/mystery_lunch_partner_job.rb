class MysteryLunchPartnerJob < ApplicationJob
  queue_as :default

  def perform
    MysteryLunch.select_new_partners
  end
end
