FactoryGirl.define do
  factory :contact do
    firstname {FFaker::Name.first_name}
    lastname {FFaker::Name.last_name}
    email {FFaker::Internet.email}

    after(:build) do |contact|
    	[:home_phone, :office_phone, :mobile_phone].each do |phone|
    		contact.phones << FactoryGirl.build(:phone, phone_type: phone, contact: contact)
    	end
    end
  end
end
