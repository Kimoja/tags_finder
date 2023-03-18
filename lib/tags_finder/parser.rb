# frozen_string_literal: true

# :nodoc:
class TagsFinder
  # :nodoc:
  class Parser
    attr_reader :results

    def self.build_html_tags_reg(tags:, gtags:)
      @@html_tags_reg = %r{<#{gtags}\s+([^>]*)>|<#{tags}\s+([^>]*)>|(</#{gtags}>)|(</#{tags}>)}i
    end

    def initialize(path, search_tags, path_tags)
      @path = path
      @search_tags = search_tags
      @path_tags = path_tags
      @gtags = []
      @tag = nil
      @results = []
    end

    def parse
      File.readlines(@path).each_with_index do |line, line_number|
        next unless (matches = line.match(@@html_tags_reg))

        next push_gtags(matches[1]) if matches[1]
        next set_tags(matches[2], line_number) if matches[2]
        next pop_gtags(line_number) if matches[3]

        push_tag(line_number)
      end

      self
    end

    private

    def push_gtags(gtags)
      @gtags << gtags.gsub(/\s+/, ' ').split
    end

    def pop_gtags(line_number)
      if @gtags.empty?
        raise TagsFinder::Error,
              "Unexpected gtag closure at #{@path}:#{line_number + 1}"
      end

      @gtags.pop
    end

    def set_tags(tags, line_number)
      @tag = tags.gsub(/\s+/, ' ').split
      @start_line = line_number
    end

    def push_tag(line_number)
      unless @tag
        raise TagsFinder::Error,
              "Unexpected tag closure at #{@path}:#{line_number + 1}"
      end

      @results << Result.new(
        path: @path,
        start_line: @start_line,
        end_line: line_number,
        tags: (@path_tags + (@gtags.last || []) + @tag).uniq,
        search_tags: @search_tags
      )

      @tag = nil
    end
  end
end
