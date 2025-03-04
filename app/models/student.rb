class Student < ApplicationRecord
    validates :first_name, presence: true
    validates :email, presence: true, uniqueness: true
end
