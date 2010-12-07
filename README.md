# RZabbix

RZabbix is a ruby client for Zabbix API access.

## Installation Instructions

To install RZabbix, run the following command:

    gem install rzabbix 
  
To use RZabbix:

    gem 'rzabbix'
    RZabbix::Base.set_credentials("zabbix.example.com", "user", "password")
    host = RZabbix::Host.find("my-dns-example.com")

## External Links


[Zabbix Monitoring Server](http://zabbix.com).

