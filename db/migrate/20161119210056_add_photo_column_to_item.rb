class AddPhotoColumnToItem < ActiveRecord::Migration
  def change
    add_column :items, :photo, :string
  end
end
