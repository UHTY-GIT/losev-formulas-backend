ActiveAdmin.register User do

  config.filters = false

  actions :all, except: [:create, :new, :show, :update, :edit]

  index do
    selectable_column
    id_column
    column 'Avatar' do |item|
      image_tag item.avatar.url, height: 100 if item.avatar.file?
    end
    column :name
    column :email
  end

end
