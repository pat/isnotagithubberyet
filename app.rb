require 'json'
require 'open-uri'
require 'sinatra'
require 'sinatra/subdomain'

class Githubber < Sinatra::Base
  register Sinatra::Subdomain

  subdomain do
    get '/' do
      begin
        @username = subdomain

        json = JSON.parse(
          open("https://api.github.com/users/#{@username}/orgs").read
        )

        if json.any? { |org| org['login'] == 'github' }
          haml :no
        else
          haml :yes
        end
      rescue
        haml :yes
      end
    end
  end
end
