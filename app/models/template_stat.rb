class TemplateStat < ApplicationRecord
  belongs_to :template, foreign_key: :template_name, primary_key: :id
end
