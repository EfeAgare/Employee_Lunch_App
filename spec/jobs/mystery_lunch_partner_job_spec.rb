require 'rails_helper'

# Part of the pain you are feeling is that you are testing implementation instead of behavior.

RSpec.describe MysteryLunchPartnerJob, type: :job do

  context "#perform_later" do

    it "calls the select_new_partners method" do

      MysteryLunchPartnerJob.perform_later
      expect(MysteryLunchPartnerJob).to have_been_enqueued.exactly(:once)
    end
  end
end
