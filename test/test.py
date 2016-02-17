#!/usr/bin/ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

BASE_URL = "https://www.ps.kz/domains/whois?domain=ps.kz"
HEADERS_HASH = {"User-Agent" => "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/532.5 (KHTML, like Gecko) Chrome/4.0.249.89 Safari/532.5"}

page = Nokogiri::HTML(open(BASE_URL, HEADERS_HASH))
rows = page.css("body table tr td")

        rows.each do |a|
                puts a.text
        end
