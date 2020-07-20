class Task < ActiveModel::Model

    include ActiveModel::Validation

    attribute id : Int64
    attribute name : String
    attribute description : String
    attribute done : Bool = false

    validates :id, presence: true
    validates :name, presence: true, length: {minimum: 3, too_short: "must be 3 characters long"}
    validates :description,  presence: true, length: {minimum: 3, too_short: "must be 3 characters long"}
    validates :done, presence: true

end
