# Smoketest.

include dns::server

dns::server::options { "${dns::server::params::cfg_dir}/named.conf.options":
  forwarders => [ '8.8.8.8', '8.8.4.4' ]
}

dns::zone { 'example.com':
  soa         => 'ns1.example.com',
  soa_email   => 'admin.example.com',
  nameservers => [ 'ns1' ],
  allow_transfer => [ '192.0.2.0', '2001:db8::/32' ],
  dns_key_name => 'rndc-key',
  dns_key_file => '/etc/bind/rndc.key',
}

dns::zone { '56.168.192.IN-ADDR.ARPA':
  soa         => 'ns1.example.com',
  soa_email   => 'admin.example.com',
  nameservers => [ 'ns1' ],
}

dns::record::a {
  'ns1':
    zone => 'example.com',
    data => [ '192.168.56.10' ],
    ptr  => true,
}

dns::acl { 'trusted':
  data => [ '192.168.10.0/24', '172.16.0.0/24' ],
}
