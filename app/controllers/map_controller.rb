# -*- encoding : utf-8 -*-
class MapController < ApplicationController
  def show

    @floor = params[:floor] || 1

    if params[:place]
      places = Place.where("code LIKE ?" , "%#{params[:place][:code].capitalize}%")
    else
      places = Place.none
    end

    @map= MapDecorator.decorate(places)

      #Place.where(code: params[:place][:code].capitalize).pluck(:code).
      # if @hash.length == 1
      #   flash[:error] = "Sala não encontrada"

  end
end
