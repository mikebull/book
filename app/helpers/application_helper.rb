require 'comments_helper'

module ApplicationHelper
  def content(chapter)
    html = markdown(chapter.body, chapter.slug, chapter.comments)

    html.html_safe
  end

  def markdown(text, slug, comments)
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

    doc.search('p').wrap('<div class="paragraph">')

    doc.search('p', 'li').each_with_index do |node, index|
      hash = CommentsHelper.create_hash(node, index)
      path = new_chapter_comment_path(chapter_slug: slug, paragraph_id: hash)
      comment_list = comments.select { |c| c.paragraph_reference.eql? hash }

      comments_node = Nokogiri::HTML::DocumentFragment.parse("<div class=\"comments\" data-paragraph-comments=\"#{hash}\"></div>").at('div')

      comment_list.each do |comment|
        comment_node = Nokogiri::HTML::DocumentFragment.parse("<div class=\"comment\"><span>#{comment.name}</span><span class=\"date\">#{time_ago_in_words(comment.created_at)}</span><p>#{comment.body}</p></div>")
        comments_node.add_child(comment_node)
      end

      new_link = Nokogiri::XML::Node.new('a', doc)
      new_link['href'] = url_for(path)
      new_link.content = 'New'
      comments_node.add_child(new_link)

      view_link = Nokogiri::XML::Node.new('a', doc)
      view_link['data-toggle'] = false
      view_link['data-paragraph'] = hash
      view_link['href'] = '#'
      view_link.content = pluralize comment_list.count, 'comment'

      node.after(comments_node)
      node.after(view_link)

    end
    doc.to_html
  end
end
