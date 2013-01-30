
require 'rubygems'
require 'bundler/setup'
require 'faraday'
require 'em-synchrony'
require 'em-synchrony/fiber_iterator'

EM.synchrony do

  conn = Faraday.new do |f|
    f.adapter :em_synchrony
  end

  actors = [1,2,3,4]

  EM::Synchrony::FiberIterator.new(actors, actors.size).map do |actor, iter|
    urls = %w[ http://www.cnn.com http://www.google.com http://reapso.com http://staging.reapso.com/signup ]
    urls.each do |url|
      resp = conn.get url
      puts "#{actor} #{url} #{resp.status}"
    end
  end

  EM.stop
end
