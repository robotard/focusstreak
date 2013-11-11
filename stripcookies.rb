module Rack
  class StripCookiesFromAPICalls
    def initialize(app, options={})
      @app   = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      if env['REQUEST_PATH'].starts_with?('/api/')
        headers.delete('Set-Cookie')
      end
      [status, headers, body]
    end
  end
end
