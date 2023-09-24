class CreateCompanyLengthMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :company_length_metrics do |t|
      t.integer :min_length
      t.integer :max_length
      t.bigint :template_name, index: true
      t.integer :sales_count
      t.boolean :extended

      t.timestamps
    end
  end
end
