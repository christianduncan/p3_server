class Animal < ApplicationRecord
    has_and_belongs_to_many :users
    geocoded_by :address
    after_validation :geocode

    def address
        [ self.city, self.state ].compact.join(', ')
    end

end
