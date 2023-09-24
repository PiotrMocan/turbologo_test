class CreateTemplateStats < ActiveRecord::Migration[7.0]
  def change
    create_table :template_stats do |t|
      t.bigint :template_name, index: true
      t.bigint :industry_id, index: true
      t.integer :impressions_count
      t.integer :clicks_count
      t.integer :sales_count

      t.timestamps
    end
  end
end
