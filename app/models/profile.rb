class Profile < ApplicationRecord
  validates :h_year1, numericality: { only_integer: true }, allow_blank: true, length: { is: 4 }
  validates :h_year2, numericality: { only_integer: true }, allow_blank: true, length: { is: 4 }
  validates :h_year3, numericality: { only_integer: true }, allow_blank: true, length: { is: 4 }
  validates :h_year4, numericality: { only_integer: true }, allow_blank: true, length: { is: 4 }
  validates :h_year5, numericality: { only_integer: true }, allow_blank: true, length: { is: 4 }
end
