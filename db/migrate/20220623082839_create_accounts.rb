class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.references :customer, null: false, foreign_key: { to_table: :customers }
      t.string :iban, null: false
      t.string :currency, null: false

      t.timestamps
    end
  end
end
