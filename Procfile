web: bundle exec puma -C config/puma.rb
release: bin/rails db:migrate
worker: bundle exec good_job --max-threads=5