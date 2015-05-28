class gitlab_cert {
  exec {'tkh_gitlab_dir':
    command => "mkdir -p /etc/gitlab",
    path => ['/bin', '/usr/bin'],
    creates => '/etc/gitlab'
  } ->
  file {'tkh_gitlab_ssl_dir':
    path => '/etc/gitlab/ssl',
    ensure => 'directory',     
  } ->
  file {'tkh_gitlab_crt':
    source => 'puppet:///modules/gitlab_cert/gitlab.kh.talex-id.net.crt',
    path => '/etc/gitlab/ssl/gitlab.kh.talex-id.net.crt',
  } ->
  file {'tkh_gitlab_key':
    source => 'puppet:///modules/gitlab_cert/gitlab.kh.talex-id.net.key',
    path => '/etc/gitlab/ssl/gitlab.kh.talex-id.net.key',
  }
}
