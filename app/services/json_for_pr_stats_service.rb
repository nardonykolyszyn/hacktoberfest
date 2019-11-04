# frozen_string_literal: true

require 'json'

module JsonForPrStatsService
  module_function

  def call
    File.open("pull_requests.json","w") do |f|
      f.write('[')
      PRStat.find_in_batches.with_index do |group, batch|
        group.each_with_index do |pr_stat, index|
          unless batch == 0 && index == 0
            f.write(',')
          end

          f.write(JSON.pretty_generate(pr_stat.data))
        end
      end
      f.write(']')
    end
  end
end
