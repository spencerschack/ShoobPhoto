class ProofImage < ActiveRecord::Base
  belongs_to :proof
  
  has_attached_file :image, :url => proc {|clip| "/proofs/#{clip.instance.proof.code}/:id.:extension"}, :path => ':rails_root/public:url'
  
  def dimensions
    geo = Paperclip::Geometry.from_file image.to_file
    "#{geo.width.to_i}x#{geo.height.to_i}"
  end
  
end
