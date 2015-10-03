class Picture < ActiveRecord::Base
  belongs_to :spot
  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "/images/:style/nophotos.jpg",
    url: "/system/spots/:attachment/:id_partition/:style/:filename",
    path: ":rails_root/public/system/spots/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
  do_not_validate_attachment_file_type :picture
end
