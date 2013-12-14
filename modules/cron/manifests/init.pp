class cron {
  service {
    'cron':
      ensure => running,
      enable => true
  }

  cron {
#    'optimize tables':
#      command => '/usr/bin/mysqlcheck -Aao –auto-repair -u root -p\!got80s',
#      user => 'root',
#      minute => '0',
#      hour => '3';
  }
}
