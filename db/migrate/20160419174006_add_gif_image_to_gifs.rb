class AddGifImageToGifs < ActiveRecord::Migration
  def change
    add_column :gifs, :gif_image_id, :string
  end
end
