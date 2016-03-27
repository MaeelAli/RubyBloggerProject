class Article < ActiveRecord::Base
	has_many :comments
	has_many :taggings
	has_many :tags, through: :taggings
	belongs_to :author

	has_attached_file :image, styles: { medium: "300x300", thumb: "50x50" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	#getter
	def tag_list
		tags.join(", ")
	end

	#setter
	def tag_list=(tag_string)
		tag_names = tag_string.split(",").collect{|s| s.strip.downcase}.uniq
		new_or_found_tags = tag_names.collect{|name| Tag.find_or_create_by(name: name)}
		self.tags = new_or_found_tags
	end

end
