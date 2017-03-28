require 'rails_helper'

RSpec.describe Contact, type: :model do
	it "has a valid factory" do
		expect(build(:contact)).to be_valid
	end

  it "is valid with a firstname, lastname, and email" do
  	contact = build(:contact, firstname: 'Ahmad Irfan', lastname: 'Mohammad Shukri', email: 'irfanshukri203@gmail.com')
  	expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
  	contact = build(:contact, firstname: nil)
  	contact.valid?
  	expect(contact.errors[:firstname]).to include("can't be blank")
  end

  it "is invalid without a lastname" do
  	contact = build(:contact, lastname: nil)
  	contact.valid?
  	expect(contact.errors[:lastname]).to include("can't be blank")
  end

  it "is invalid without an email address" do
  	contact = build(:contact, email: nil)
  	contact.valid?
  	expect(contact.errors[:email]).to include("can't be blank")
  end

  it "is invalid with duplication of email address" do
  	FactoryGirl.create(:contact, firstname: 'John', lastname: 'Tester', email: 'tester@testemail.com')
  	contact = build(:contact, firstname: 'james', lastname: 'Tester', email: 'tester@testemail.com')
  	contact.valid?
  	expect(contact.errors[:email]).to include("has already been taken")
  end

  it "returns a contact's full name as a string" do
  	contact = build(:contact, firstname: "Ahmad Irfan", lastname: "Mohammad Shukri", email: "irfanshukri203@gmail.com")
  	expect(contact.name).to eq('Ahmad Irfan Mohammad Shukri')
  end

  it "has three phone numbers" do
  	expect(create(:contact).phones.count).to eq(3)
  end

  describe "filter first name by filters" do
  	before :each do
			@smith = Contact.create(firstname: "Smith", lastname: "Hudson", email: "smith_hudson@gmail.com")
			@joey = Contact.create(firstname: "Joey", lastname: "Greenday", email: "joey_greenday@gmail.com")
			@josh = Contact.create(firstname: "Josh", lastname: "Teng", email: "josh_teng@gmail.com")
		end

  	context "making letters" do
  		it "returns a sorted array of results that match" do
  			expect(Contact.by_letter("J")).to eq [@joey, @josh]
  		end
  	end

  	context "non-matching letters" do
  		it "omits results that do not match" do
  			expect(Contact.by_letter("J")).not_to include @smith
  		end
  	end
  end
end
