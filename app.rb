class App < Grape::API
  format :json

  desc 'Root'
  get '/' do
    {}
  end
end
