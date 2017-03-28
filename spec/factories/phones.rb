FactoryGirl.define do
  factory :phone do
  	association :contact
    phone_number {FFaker::PhoneNumber.phone_number}

  	factory :home_phone do
	  	phone_type "home"
	  end

	  factory :office_phone do
	  	phone_type "office"
	  end

	  factory :mobile_phone do
	  	phone_type "mobile"
	  end
  end
end
