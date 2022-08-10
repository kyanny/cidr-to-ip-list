require 'sinatra'
require 'ipaddr'

get '/' do
    cidr = params['cidr'] || '192.168.0.0/24'
    begin
        ips = IPAddr.new(cidr).to_range
    rescue IPAddr::InvalidAddressError => error
        p error.inspect
    end
    erb :index, locals: { ips: ips, cidr: cidr, error: error }
end