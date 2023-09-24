class CreateAdvancedMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :advanced_metrics do |t|
      t.boolean :slogan_exists
      t.bigint :industry_id, index: true
      t.boolean :icon_selected
      t.bigint :template_name, index: true
      t.integer :sales_count

      t.timestamps
    end
  end
end
