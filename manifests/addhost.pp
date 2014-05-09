# == Type: hosts::addhost
#
# A type to add entries to /etc/hosts
#
# === Parameters
# ["ipaddress"]
#   IP address of the host
#
# ["hostname"]
#   Host name
#
# ["aliases"]
#   An array of aliases for the host

define hosts::addhost($ipaddress, $hostname, $aliases = []) {
  augeas { $title:
    context => '/files/etc/hosts',
    changes => template('hosts/hosts.erb'),
    onlyif  => "match *[ipaddr = '${ipaddress}'] size == 0",
  }
}
