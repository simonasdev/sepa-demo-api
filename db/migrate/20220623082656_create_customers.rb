class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.text :email, null: false
      t.text :password_digest, null: false
      t.text :full_name, null: false

      t.timestamps
    end
  end
end
