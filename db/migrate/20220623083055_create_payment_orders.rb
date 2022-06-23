class CreatePaymentOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_orders do |t|
      t.references :issuer, null: false, foreign_key: { to_table: :customers }
      t.references :receiver, null: false, foreign_key: { to_table: :customers }
      t.integer :amount, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
