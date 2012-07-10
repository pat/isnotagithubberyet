require 'json'
require 'open-uri'
require 'sinatra'
require 'sinatra/subdomain'

class Githubber < Sinatra::Base
  register Sinatra::Subdomain

  subdomain do
    get '/' do
      begin
        json = JSON.parse(
          open("https://api.github.com/users/#{subdomain}/orgs").read
        )

        json.any? { |org| org['login'] == 'github' }
      rescue
        false
      end
    end
  end
end
