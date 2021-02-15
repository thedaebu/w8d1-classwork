class Sub < ApplicationRecord
    validates :title, :description, :model_id, presence: true


    belongs_to :moderator,
        foreign_key: :moderator_id,
        class_name: :User
end
