class ppa {
  package {
    'python-software-properties':
      ensure => present,
  }
  exec {
    'ppa-add-repo-php5':
      command => 'add-apt-repository ppa:ondrej/php5',
      creates => '/etc/apt/sources.list.d/php5-precise.list',
      require => Package['python-software-properties'];
    'ppa-add-repo-php5-apcu':
      command => 'add-apt-repository ppa:ondrej/php5-apcu',
      creates => '/etc/apt/sources.list.d/php5-apcu-precise.list',
      require => Package['python-software-properties'];
    'ppa-add-repo-nginx-stable':
      command => 'add-apt-repository ppa:nginx/stable',
      creates => '/etc/apt/sources.list.d/nginx-stable-precise.list',
      require => Package['python-software-properties'];
    'ppa-update':
      command => 'aptitude -y update && touch /root/.ppa-update',
      creates => '/root/.ppa-update',
      require => Exec['ppa-add-repo-php5', 'ppa-add-repo-php5-apcu',  'ppa-add-repo-nginx-stable'];
  }
}
