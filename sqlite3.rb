# frozen_string_literal: true

require './lib/snackHack2'
require 'sqlite3'
# input = "netflix.com"
# table_name = input.split(".")[0]
# input = input.gsub(, "")
# begin
#   db = SQLite3::Database.new "test.db"
#   rows = db.execute("create table #{table_name} (ip varchar(30));")
# rescue SQLite3::SQLException
# end
# Create a table
#
# ip   = Snackhack2::IpLookup.new
# dns  = Snackhack2::Dns.new
# dns.site = input.to_s
# ns        = dns.nameserver
# ns.each do |i|
#   ip.site = i
#   ips = ip.get_ip.shift
#   check = db.execute( "select * from #{table_name} where ip='#{ips}'" )
#   if check.nil?
#     db.execute "insert into #{table_name} values ( ? )", ips
#   end
#   #
# end
# db.execute( "select * from #{table_name} where ip='#{ips}'" )
class Sql
  def initialize(site)
    @site = site
    @db   = SQLite3::Database.new 'test2.db'
  end

  def site
    @site.split('.')[0]
  end
end

class Ips < Sql
  def create_table
    ct = @db.execute("create table #{site}_ip (ip varchar(30));")
    puts "#{site}_ip table generated..." if ct.empty?
  rescue SQLite3::SQLException
    puts 'Table Exists Already'
  end

  def dump_table
    @db.execute("select * from #{site}_ip;").each do |rows|
      puts rows
    end
  rescue SQLite3::SQLException
  end

  def recon
    ips  = []
    ip   = Snackhack2::IpLookup.new
    dns  = Snackhack2::Dns.new
    dns.site  = @site
    ns        = dns.nameserver
    ns.each do |i|
      ip.site = i
      ips     = ip.get_ip.shift
      begin
        check = @db.execute("select * from #{site}_ip where ip='#{ips}'")
        unless check.nil?
          puts ips
          @db.execute "insert into #{site}_ip values ( ? )", ips
        end
      rescue SQLite3::SQLException
      end
    end
  end
end

class Ports
  def create_table; end
end
Ips.new('netflix.com')
# sql.create_table
# sql.recon
# sql.dump_table
# sql.recon
