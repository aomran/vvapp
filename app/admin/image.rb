ActiveAdmin.register Image do
  belongs_to :submission

  index :as => :grid do |image|
    link_to(image_tag(image.image_file_url(:thumb)), image.image_file.url)
  end
end
