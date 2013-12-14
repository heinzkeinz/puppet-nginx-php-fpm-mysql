class mysql {
  package {
    ['mysql-common', 'mysql-client', 'mysql-server']:
      ensure => present
  }
  
  # Create a symlink to /etc/init/*.conf in /etc/init.d, because Puppet 2.7 looks there incorrectly (see: http://projects.puppetlabs.com/issues/14297)
  file { '/etc/init.d/mysql':
    ensure => link,
    target => '/lib/init/upstart-job',
  }

  # Ensure that the service is running.
  service { 'mysql':
      enable => true,
      ensure => running,
      provider => 'upstart',
      require => File['/etc/init.d/mysql']
  }

  exec {
    'set-root-password':
      subscribe => [Package['mysql-common'], Package['mysql-client'], Package['mysql-server']],
      refreshonly => true,
      unless => "mysqladmin -uroot -p$mysql_password status",
      command => "mysqladmin -uroot password $mysql_password",
  }

  file {
    '/etc/mysql/my.cnf':
      source => 'puppet:///modules/mysql/my.cnf',
      require => Package['mysql-server'],
      notify => Service['mysql'];
  }
}
