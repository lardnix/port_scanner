# frozen_string_literal: true

require 'socket'

def usage
  puts "[USAGE]: #{__FILE__} <host> [quick/all]"
  puts '[SUBCOMMNADS]:'
  puts '  quick:                    - test most common ports'
  puts '  full:                     - test all ports'
end

def test_port(host, port)
  s = TCPSocket.new host, port, connect_timeout: 5
  puts "[#{host}]: port #{port} is open"
  s.close
end

def test_ports(host, ports)
  has_open_ports = false

  ports.each do |port|
    test_port host, port
    has_open_ports = true
  rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, IO::TimeoutError
    next
  rescue Interrupt
    break
  end

  has_open_ports
end

most_common_ports = [
  80,
  443,
  21,
  22,
  110,
  995,
  143,
  993,
  25,
  26,
  587,
  3306,
  2082,
  2083,
  2086,
  2087,
  2095,
  2096,
  2077,
  2078
]

if ARGV.length != 2
  usage
  exit
end

host = ARGV[0]
subcommand = ARGV[1]

case subcommand
when 'quick'
  puts '[INFO]: Quick scan...'
  puts "[#{host}]: has no open ports" unless test_ports host, most_common_ports
when 'full'
  puts '[INFO]: Full scan...'
  puts "[#{host}]: has no open ports" unless test_ports host, (1..65_535)
else
  usage
  puts "[ERROR]: Unknown subcommand '#{subcommand}'"
end
