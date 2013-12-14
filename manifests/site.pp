Exec { path => "/usr/sbin/:/sbin:/usr/bin:/bin" }
File { owner => 'root', group => 'root' }

node 'default' {
  import 'settings'

  include puppet
  include iptables
  include ppa
  include system
  include mysql
  include mysqltuner
  include nginx
  include ntp
  include php
  include mysqltuner
  include tuningprimer
  include htop
  include unzip
}
