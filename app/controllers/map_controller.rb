class MapController < ApplicationController
  def show
    @hash ={"background" => "#696969"}
    if params[:place]
      Place.where(code: params[:place][:code].capitalize).pluck(:code).each do |x|
        @hash[x]= "#729ae3"
      end
    end

    @result= @hash.to_json
  end
end
