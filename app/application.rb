 class Application

   @@items = [Item.new("Figs",3.42), Item.new("Pears",0.99)]

   def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

#Route
    if req.path.match(/items/) #path method of our Rack::Request object
      item_name = req.path.split("/items/").last #split =>'/items/Figs' into an array of substrings. Then call last to find the search term.

      if item = @@items.find{|item| item.name == item_name}
        resp.write item.price
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status = 404
      resp.write "Route not found"
    end
    resp.finish
  end

 end

 # 1. Your application should only accept the `/items/<ITEM NAME>` route. Everything else should `404`
 # 2. If a user requests `/items/<Item Name>` it should return the price of that item
 # 3. IF a user requests an item that you don't have, then return a `400` and an error message
