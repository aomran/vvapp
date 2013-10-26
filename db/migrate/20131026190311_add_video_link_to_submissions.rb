class AddVideoLinkToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :video_link, :string
  end
end
