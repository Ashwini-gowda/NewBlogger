class Article < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_many :comments, as: :commentable
  has_and_belongs_to_many :sub_categories
  belongs_to :user
 

  accepts_nested_attributes_for :sub_categories
  #accepts_nested_attributes_for :users
  
  searchkick searchable: [:title, :author],
             text_middle: [:title, :author]

  def search_data
    {
      title: title,
      author: author,
    }
  end

  def title_with_author
    "#{self.title} in #{self.author rescue ''}" 
  end

    def image_path
    image.file.file.presigned_url(:get).to_s rescue image_url(:thumb)
  end

end
