def default_value(val, default)
  if val.nil?
    return default
  end
  if val === 'true'
    return true
  elsif val === 'false'
    return false
  elsif val.is_a? Numeric
    return BigDecimal.new(val).to_i
  else
    return val
  end
end

def str_to_arr(input)
  input = default_value(input, [])
  if input === []
    return input
  end
  return input.split(',')
end

def generatePassword() 
  return rand(36**10).to_s(36)
end

nzbConfig = {
  :password => default_value(ENV['nzb_password'], generatePassword())
}

Chef::Log.info("NZBGet username: nzbget, password: #{nzbConfig[:password]}")

template '/storage/config/nzbget.conf' do
  source 'nzbget.conf.erb'
  variables ({ :confvars => nzbConfig })
  owner 'nzbget'
  group 'nzbget'
  action :create_if_missing
end

dirs = %w(dst inter nzb queue tmp scripts config/ssl)
dirs.each do |dir|
  directory "/storage/#{dir}" do
    owner 'nzbget'
    group 'nzbget'
    action :create
    recursive true
  end
end

execute 'create_ssl_certificates' do
  cwd '/storage/config/ssl'
  command <<-EOH
    openssl req -subj "/CN=nzbget.local/O=FakeOrg/C=UK" -new -newkey rsa:2048 -days 1365 -nodes -x509 -sha256 -keyout key.pem -out cert.pem
  EOH
  user 'nzbget'
  group 'nzbget'
  not_if { File.exist?('/storage/config/ssl/key.pem') }
end
