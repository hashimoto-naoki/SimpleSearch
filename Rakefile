#!/usr/bin/env ruby

task :default => ['lib/simple-search.js', 'lib/simple-search-config.js']

file 'lib/simple-search.js' => ['src/simple-search.coffee'] do |coffee_file|
  sh "coffee -co lib src/simple-search.coffee"
end

file 'lib/simple-search-config.js' => ['src/simple-search-config.coffee'] do |coffee_file|
  sh "coffee -co lib src/simple-search-config.coffee"
end

