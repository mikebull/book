class ParagraphEditWorker
  include Sidekiq::Worker

  def perform(id)
    chapter = Chapter.find(id)

    markdown = Redcarpet::Markdown.new(::Redcarpet::Render::HTML,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      autolink: true,
      tables: true,
      underline: true,
      highlight: true)

    doc = Nokogiri::HTML(markdown.render(chapter.body).html_safe)

    paragraphs = doc.search('p, li')
    
    paragraphs.each_with_index do |paragraph, index|
      text = paragraph.inner_html
      hash = CommentsHelper.create_hash(paragraph, index)

      old_paragraphs = Paragraph.where(paragraph: text)

      if old_paragraphs.exists?
        # The text is there, is it the same location?
        if !old_paragraphs.find_by_node_position(index).nil?
          # all good
        else
          # different position, re-hash
          old_paragraph = old_paragraphs.first
          old_hash = old_paragraph.paragraph_reference
          
          new_hash = CommentsHelper.create_hash(paragraph, index)
          
          old_paragraph.paragraph_reference = new_hash
          old_paragraph.save!

          # Update comments with old hash to use new one
          comments = Comment.where(paragraph_reference: old_hash)

          comments.each do |comment|
            comment.paragraph_reference = new_hash
            comment.save!
          end
        end
      else
        # Try to find paragraph that is close
        match = chapter.paragraphs.first { |n| n if n.paragraph.similar(text) > 80.0 }

        if !match.nil?
          current_hash = match.paragraph_reference
          new_hash = CommentsHelper.create_hash(paragraph, index)

          match.paragraph_reference = new_hash
          match.paragraph = text
          match.node_position = index
          match.save!

          comments = Comment.where(paragraph_reference: current_hash)

          comments.each do |comment|
            comment.paragraph_reference = new_hash
            comment.save!
          end
        else
          # Otherwise, create new paragraph
          Paragraph.create(
            chapter: chapter,
            paragraph_reference: CommentsHelper.create_hash(paragraph, index),
            paragraph: text,
            node_type: paragraph.name,
            node_position: index
          )
        end
      end

      #- Loop through each new paragraph
      #- If text and position matches, leave
      #- Else, try to find paragraph that is closest, and assign new hash to comments
      #- Otherwise, orphan and show at bottom.
    end
  end
end
