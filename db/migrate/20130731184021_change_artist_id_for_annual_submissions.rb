class ChangeArtistIdForAnnualSubmissions < ActiveRecord::Migration
  def change
    remove_column :annual_submissions, :artist_id
    add_reference :annual_submissions, :user, index: true
  end
end
