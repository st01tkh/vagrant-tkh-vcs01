node default {
  manageusers::create_account { talex_id:
    name       => "talex_id",
    uid        => "16400",
    password   => '$6$BwIPxFhj$H8sVaMjoYYUMwXojt/uVdObPuMYKjvLbDNFZ.z1bCFy8DcO7vkWw4lqWAD6tKiAhnrrtntWr3biL4X67cYrq1/',
    shell      => "/bin/bash",
    groups     => ['sudo'],
    sshkeytype => "ssh-rsa",
    sshkey     => "AAAAB3NzaC1yc2EAAAADAQABAAACAQDB51QyzrsKloN72z3YDiFLHcVEe+TyFSv82GiChzd5bijJLFlrqERNsXh816UV6XZ+35hFDASGySOSDI5ZWe5MWA40DFHlyNpYMHxezD3BtJ803WEG8nK4Ze3LPdKLuCdAXhJBoHHrxXBIVwe+B35J5XdMJTxkB6QiVvbSJNNEQat+EbiKSXs5DofP0P7h6nhlIFX3s61ZLS8OLiwMB20fql91td7yKx01FcIDHVJ5f2AJOWybv5wtYkUgDhDNGhTmGK4tMzflRgLnKQtX26wSqa20UnjIsiXTxmiiPgNlUJUIZVzICWjAUCM9ISd8XOK8ezRsxtKu32IRMWE4S4u0DkuLlBI/BVmrbPjFrPY8MsTyGG04V8ejN2+iASNLNKcFBc5Y0zZwmyMUHZfBTz+6rRkrnQ6YgVsc/7qykQ5a237P8sMTaWygdt/pNOGFPz8sCAT2rgH2jPCYKjTwrMgrI2WKL3572mrUwI8q4YMT/hKnzV9dKW+8/o9JlcxtKvvdsEzXH2Lj1KWWIBrrsopNdhnuwRBX+y/nWBDj9DC3ZaHE/4R971JR2EYNiDKr4b6ot4LC0ITLrIq2PibGSx27jxP5sLIbPqzhB7r1U0IOoApRx5ZmOtUoupzdZi9M3QD/rT4VRTLo4oS86QxSUWs//os9yvxIXZzyridWxxiEPw==",
  }

  class { 'server':
    packages        => ['vim', 'htop', 'tree', 'telnet', 'whois', 'screen', 'lvm2', 'mdadm'],
    packages_ensure => 'latest',
    apt_update_interval => 'daily', 
    timezone => 'Europe/Moscow',
    swap_enabled => true,
  }

  firewall { '100 allow http and https access':
    port   => [80, 443],
    proto  => tcp,
    action => accept,
  }

  class {'postfix_satellite': }

  class {'gitlab_cert': } ->
  class { 'gitlab':
    gitlab_branch => '7.3.0',
    external_url => 'https://gitlab.kh.talex-id.net',
    puppet_manage_config   => true,
    puppet_manage_backups  => true,
    puppet_manage_packages => true,
    ssl_certificate        => '/etc/gitlab/ssl/gitlab.kh.talex-id.net.crt',
    ssl_certificate_key    => '/etc/gitlab/ssl/gitlab.kh.talex-id.net.key',
    redirect_http_to_https => true,
    backup_keep_time       => 51840000, # In seconds, 5184000*10 = 60*10 days
    gitlab_default_projects_limit => 100,
  }
}
