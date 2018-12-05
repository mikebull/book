require 'digest/sha1'

module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(::Redcarpet::Render::HTML,
                                     no_intra_emphasis: true,
                                     fenced_code_blocks: true,
                                     disable_indented_code_blocks: true,
                                     autolink: true,
                                     tables: true,
                                     underline: true,
                                     highlight: true)

    html = markdown.render(text).html_safe

    doc = Nokogiri::HTML(html)

    doc.search('p').each do |node|
      hash = Digest::SHA1.hexdigest(node.inner_html)[0...10]
      node['data-paragraph'] = hash

      path = new_chapter_comment_path(chapter_slug: params[:slug], paragraph_id: hash)

      link = Nokogiri::XML::Node.new('a', doc)
      link['href'] = url_for(path)
      link.content = 'New'

      node.after(link)
    end

    doc.to_html.html_safe
  end
end
