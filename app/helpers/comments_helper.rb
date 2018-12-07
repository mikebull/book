require 'digest/sha1'

module CommentsHelper
  def self.create_hash(node, position)
    # Get type of node (p, li)
    node_type = node.name

    # Create hash of inner text/html
    text = node.inner_html

    str = "#{node_type}-#{position}-#{text}"

    Digest::SHA1.hexdigest(str)[0...5]
  end
end
