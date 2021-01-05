class TestApiController < ApplicationController
  def directions
    response = { "directions"=>
     %w[forward right forward forward forward left forward forward left right forward right forward forward right forward forward left]
    }
    render json: response
  end

  def location
    response = {
      "you said" => "x: #{params[:x]} , y: #{params[:y]}",
      "result" => "maybe you're right"
    }
    render json: response
  end
end
