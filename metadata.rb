name             'cookbook_hub'
maintainer       'Fred Thompson'
maintainer_email 'fred.thompson@buildempire.co.uk'
license          'Apache 2.0'
description      'The JetBrains Hub site.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.5'

recipe 'cookbook_hub', 'The JetBrains Hub site.'

%w{ ubuntu }.each do |os|
  supports os
end

%w{build-essential appbox java}.each do |cb|
  depends cb
end