class Phone < ApplicationRecord
	belongs_to :contact

	validates :phone_number, uniqueness: {scope: :contact_id}
end
