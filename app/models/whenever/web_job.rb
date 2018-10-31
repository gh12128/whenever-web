require 'whenever/patches/job'

module Whenever
  class WebJob
    include ActionView::Helpers::DateHelper
    attr_reader :interval

    def initialize job, interval
      @job      = job
      @interval = interval
    end

    # delegate :output, :at, to: :@job

    def task
      @job[1][0].options[:task]
    end

    def description
      # @job.options.fetch(:description) { task }
      if @job[1][0].options[:description].present?
        @job[1][0].options[:description]
      else
        task
      end
    end

    def interval
      distance_of_time_in_words(@job[0])#.gsub('about', '')
    rescue ArgumentError
      @interval
    end

    def roles
      @job[1][0].roles.join(', ')
    end

    def at
      @job[1][0].at
    end

    def to
      @job[1][0].at
    end

    def output
      @job[1][0].options[:output]
    end

  end
end
