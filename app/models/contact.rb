class Contact < ApplicationRecord
	validates_presence_of :firstname
	validates_presence_of :lastname
	validates :email, presence: true, uniqueness: true

	has_many :phones

	def name
		[firstname, lastname].join(' ')
	end

	def self.by_letter(letter)
		where("firstname LIKE ?", "#{letter}%").order(:firstname)
	end
end
