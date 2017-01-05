class Asset < ActiveRecord::Base
	belongs_to :assetable, polymorphic: true
	
	has_attached_file :asset, 
		url: "/attachments/:assetable_type/:assetable_id/:id_:basename.:extension",
    path: ":rails_root/public/attachments/:assetable_type/:assetable_id/:id_:basename.:extension"

  do_not_validate_attachment_file_type :asset
  validates_attachment_presence :asset
  validates_presence_of :title
end
