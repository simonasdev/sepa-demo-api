class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.references :order, null: false, foreign_key: { to_table: :payment_orders }
      t.datetime :executed_at
      t.references :source, null: false, foreign_key: { to_table: :accounts }
      t.references :target, null: false, foreign_key: { to_table: :accounts }

      t.timestamps
    end
  end
end
