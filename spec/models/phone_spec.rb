require 'rails_helper'

RSpec.describe Phone, type: :model do
	it "does not allow duplicate phone numbers per contact" do
		contact = Contact.create(firstname: 'Joe', lastname: 'Tester', email: 'tester@testemail.com')
		contact.phones.create(phone_type: 'home', phone_number: '012345678')
		mobile_phone = contact.phones.build(phone_type: 'mobile', phone_number: '012345678')

		mobile_phone.valid?
		expect(mobile_phone.errors[:phone_number]).to include("has already been taken")
	end

	it "allows two contacts to share a phone number" do
		contact = Contact.create(firstname: "Joe", lastname: "Tester", email: "tester@testemail.com")
		contact.phones.create(phone_type: "home", phone_number: "012345678")

		other_contact = Contact.new
		other_phone = other_contact.phones.build(phone_type: "home", phone_number: "012345678")

		expect(other_phone).to be_valid
	end
end
