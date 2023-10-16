.PHONY: init
init:
	bundle install --path=vendor/bundle -j 4
	mysql -u root -pishocon1 ishocon1 < add_index.sql

.PHONY: restart
restart:
	cd ~/webapp/ruby
	git pull
	bundle exec foreman restart
