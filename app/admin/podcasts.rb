ActiveAdmin.register Podcast do

  config.filters = false

  permit_params :title, :description, :position, :image, :audio

  sortable tree: false

  index as: :sortable do
    label 'Podcast' do |podcast|
      "id: #{podcast.id}<br>title: #{podcast.title}<br>description: #{podcast.description}<br>#{image_tag podcast.image.url, height: 100}".html_safe
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :description
      row :audio
      row 'Image' do |item|
        image_tag item.image_url, height: 300 if item.image_url
      end
      row 'Audio' do |item|
        audio_tag item.audio.url, controls: true if item.audio.file?
      end
      row :position
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :image, as: :image_with_preview
      f.input :audio, as: :file
    end
    f.actions
  end

end