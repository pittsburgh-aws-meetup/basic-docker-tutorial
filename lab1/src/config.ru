require "roda"

class App < Roda
  route do |r|
    # GET / request
    r.root do
      r.redirect "/welcome"
    end

    # /welcome branch
    r.on "welcome" do
      # Set variable for all routes in /welcome branch
      @greeting = "Welcome to the Pittsburgh AWS Users' group"

      # /welcome request
      r.is do
        # GET /welcome request
        r.get do
          "#{@greeting}!"
        end
      end
    end
  end
end

run App.freeze.app
