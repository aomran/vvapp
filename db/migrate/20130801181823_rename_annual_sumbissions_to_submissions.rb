class RenameAnnualSumbissionsToSubmissions < ActiveRecord::Migration
  def change
    rename_table :annual_submissions, :submissions
  end
end
