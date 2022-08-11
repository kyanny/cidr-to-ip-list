require 'sinatra'
require 'sinatra/json'
require 'ipaddr'

helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end
end

get '/' do
    cidr = params['cidr'] || '192.168.0.0/24'
    begin
        ips = IPAddr.new(cidr).to_range
    rescue IPAddr::InvalidAddressError => error
        p error.inspect
    end

    format = params['format'] || 'html'
    p format
    case format
    when 'html'
        erb :index, locals: { ips: ips, cidr: cidr, error: error }
    when 'json'
        json ips.to_a
    when /te?xt/
        content_type 'text/plain'
        ips.map(&:to_s).join("\n") + "\n"
    end
end