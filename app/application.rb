require 'pry'
class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match("/items/")
      # get the item_name for checking
      item_name = req.path.split("/items/").last
      # look for the item
      requested_item = []
      @@items.each do |item|
        if item.name == item_name
          requested_item = item
        end
      end
      if requested_item == []
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write requested_item.price
        resp.status = 200
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

end
