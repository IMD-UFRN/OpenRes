# -*- encoding : utf-8 -*-
class ClassSuggestionWorker
  include Sidekiq::Worker

  def perform(name, count)
    puts 'Doing hard work'
  end
end
