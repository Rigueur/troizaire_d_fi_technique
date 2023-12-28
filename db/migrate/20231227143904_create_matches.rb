class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.integer :team_a_point
      t.integer :team_b_point
      t.integer :team_a_kill
      t.integer :team_b_kill

      t.references :tournament, null: false, foreign_key: true
      t.references :team_a, null: false,  foreign_key: { to_table: :teams }
      t.references :team_b, null: false,  foreign_key: { to_table: :teams }

      t.timestamps
    end
  end
end
