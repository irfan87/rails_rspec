require 'rails_helper'

RSpec.describe Phone, type: :model do
	it "does not allow duplicate phone numbers per contact" do
		contact = create(:contact)
		create(:home_phone, contact: contact, phone_number: '012345678')
		mobile_phone = build(:mobile_phone, contact: contact, phone_number: '012345678')

		mobile_phone.valid?
		expect(mobile_phone.errors[:phone_number]).to include("has already been taken")
	end

	it "allows two contacts to share a phone number" do
		create(:phone, phone_type: "home", phone_number: "012345678")

		expect(build(:phone, phone_type: "home", phone_number: "012345678")).to be_valid
	end
end
