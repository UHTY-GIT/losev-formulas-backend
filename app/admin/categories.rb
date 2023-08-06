ActiveAdmin.register Category do

  permit_params :name, :category_type

  config.filters = false

  index do
    id_column
    column :name
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :category_type
      row :created_at
      row :updated_at
      row "Podcasts" do |item|
        item.podcasts.map{ |p| link_to p.title, admin_podcast_path(p.id) }.join(', ').html_safe
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :category_type, as: :select2
    end
    f.actions
  end

end