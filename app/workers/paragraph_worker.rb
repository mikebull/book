class ParagraphWorker
  include Sidekiq::Worker

  def perform(id)
    chapter = Chapter.find(id)

    # TODO: Loop through paragraphs
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
      Paragraph.create(
        chapter: chapter,
        paragraph_reference: CommentsHelper.create_hash(paragraph, index),
        paragraph: text,
        node_type: paragraph.name,
        node_position: index
      )
    end
  end
end
