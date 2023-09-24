class Template < ApplicationRecord
  has_many :template_stats, foreign_key: :template_name, primary_key: :id
end
