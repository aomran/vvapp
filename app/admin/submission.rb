ActiveAdmin.register Submission do

  index do
    column :user, sortable: :first_name do |sub|
      if sub.user
        link_to "#{sub.user.first_name} #{sub.user.last_name}", admin_user_path(sub.user)
      end
    end


    column :cv do |sub|
      link_to 'CV', sub.cv.url
    end
    column :artist_statement do |sub|
      link_to 'Démarche', sub.artist_statement.url
    end
    column :expo_project do |sub|
      link_to 'Projet', sub.expo_project.url
    end
    column :special_needs do |sub|
      link_to 'Exigences Spéciales', sub.special_needs.url if sub.special_needs.url
    end
    column :image_list do |sub|
      link_to "Liste d'Images", sub.image_list.url
    end
    column :images do |sub|
      if sub.images
        link_to "Voir Images", admin_submission_images_path(sub)
      end
    end
    column :video_link do |sub|
      link_to "Lien Video", sub.video_link
    end
    column :created_at
    column :complete
    default_actions
  end

end
