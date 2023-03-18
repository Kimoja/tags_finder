# frozen_string_literal: true

# :nodoc:
class TagsFinder
  # :nodoc:
  class Result
    attr_reader :path, :start_line, :end_line, :tags, :search_tags

    def initialize(
      path:, start_line:, end_line:, tags:, search_tags:
    )
      @path = path
      @start_line = start_line
      @end_line = end_line
      @tags = tags
      @search_tags = search_tags
    end

    def score
      @score ||= begin
        similarities = @search_tags.map do |search_tag|
          @tags.map do |tag|
            String::Similarity.cosine(search_tag, tag)
          end.max || 0
        end

        similarities.sum / search_tags.length.to_f
      end
    end

    def extract
      File.read(@path).split("\n")[@start_line..@end_line] * "\n"
    end
  end
end
