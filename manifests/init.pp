class nginx (
  String  $version           = 'latest',
  String  $secretdata        = 'not secret',
)
{
  package { 'nginx':
    ensure => $version,
  }

  $os_details = $facts['os']['distro']['description']

  file {'/var/www/html/index.html':
    ensure  => file,
    path    => '/var/www/html/index.html',
    mode    => '0644',
    content => epp('nginx/index.html.epp', {'os_details' => $os_details,'secretdata' => $secretdata}),
    require => Package['nginx'],
  }

  service { 'nginx':
    ensure => 'running',
    name   => 'nginx',
    enable => true,
  }
}
