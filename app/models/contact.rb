class Contact < ApplicationRecord
	has_many :phones

	validates_presence_of :firstname
	validates_presence_of :lastname
	validates :email, presence: true, uniqueness: true

	def name
		[firstname, lastname].join(' ')
	end

	def self.by_letter(letter)
		where("firstname LIKE ?", "#{letter}%").order(:firstname)
	end
end
