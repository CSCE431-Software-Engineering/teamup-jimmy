class UpdateDefaultAgePref < ActiveRecord::Migration[7.0]
  def up
    change_column_default :students, :age_start_pref, from: nil, to: 18
    change_column_default :students, :age_end_pref, from: nil, to: 99
  end

  def down
    change_column_default :students, :age_start_pref, from: 18, to: nil
    change_column_default :students, :age_end_pref, from: 99, to: nil
  end
end
