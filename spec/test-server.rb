require 'rack/test'

RSpec.describe Sinatra::Demo do
  include Rack::Test::Methods
  describe 'server' do
    def app
      Sinatra::Application
    end
    context 'to test' do
      it "default URL" do
        get '/'
        expect(last_response.body).to eq("Hello Sinatra!")
      end
    end
  end
end
