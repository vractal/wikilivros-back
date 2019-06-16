class Book < ApplicationRecord
  has_one_attached :cover_file
  has_one_attached :book_file
end
