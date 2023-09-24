class CreateTemplates < ActiveRecord::Migration[7.0]
  def change
    create_table :templates do |t|
      t.string :preview_image
      t.boolean :icon_required
      t.boolean :slogan_required

      t.timestamps
    end
  end
end
