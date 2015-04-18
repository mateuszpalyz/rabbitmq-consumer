class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :uuid
      t.json :rates

      t.timestamps null: false
    end
  end
end
