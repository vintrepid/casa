class AddIsActiveToSupervisorVolunteer < ActiveRecord::Migration[6.0]
  def change
    add_column :supervisor_volunteers, :is_active, :boolean, default: true
    add_column :supervisor_volunteers, :deactivated_at, :datetime
  end
end
