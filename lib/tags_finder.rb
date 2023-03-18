# frozen_string_literal: true

require 'string-similarity'
require 'pathname'
require 'etc'

# :nodoc:
class TagsFinder
  VERSION = '0.1.0'

  # :nodoc:
  class Error < StandardError; end

  def initialize(
    search_tags:,
    search_globs:,
    result_size: 10,
    parallelism: Etc.nprocessors,
    html_tags: { tags: 'tags', gtags: 'gtags' }
  )
    @search_tags = search_tags
    @search_globs = search_globs
    @result_size = result_size
    @parallelism = parallelism

    Parser.build_html_tags_reg(**html_tags)
  end

  def find(&)
    results.each_slice(@result_size, &)
  end

  private

  def results
    paths = Dir.glob(@search_globs)
    slice_size = (paths.length / @parallelism.to_f).ceil

    jobs = paths.each_slice(slice_size).map do |paths_slice|
      job = Job.new do
        paths_slice.flat_map do |path|
          parser = Parser.new(
            path,
            @search_tags,
            path_tags(path)
          )

          parser.parse.results
        rescue StandardError => e
          puts e.message if e.is_a?(TagsFinder::Error)
        end
      end

      job.call
    end

    jobs
      .map(&:result)
      .flatten
      .compact
      .sort_by(&:score)
      .reverse
  ensure
    jobs&.each do |job|
      Process.kill('HUP', job.pid)
    rescue StandardError
    end
  end

  def path_tags(path)
    pathname = Pathname.new(File.expand_path(path))

    search_pathnames.each do |search_pathname|
      relative = pathname.relative_path_from(search_pathname)
      next nil if relative.to_s.start_with?('..')

      return relative.to_s.gsub(/\..+$/, '').split('/')
    end

    []
  end

  def search_pathnames
    @search_pathnames ||= @search_globs.map do |glob|
      Pathname.new(File.expand_path(glob.gsub(/\*+.*$/, '')))
    end
  end
end

require_relative 'tags_finder/parser'
require_relative 'tags_finder/job'
require_relative 'tags_finder/result'
