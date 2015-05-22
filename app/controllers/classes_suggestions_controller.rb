# -*- encoding : utf-8 -*-
class ClassesSuggestionsController < ApplicationController
  def index
  end

  def results
    @classes = JSON.parse($redis.get("classes"))

    @possibilities = $redis.keys("result-*").map{ |x|
      JSON.parse($redis.get(x))
    }
  end

end
