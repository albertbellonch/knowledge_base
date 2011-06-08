set :job_template, "/usr/local/bin/rvm-shell -c ':job'"
job_type :be_rake,    "cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

every 1.hour do
  be_rake "ts:reindex"
end
