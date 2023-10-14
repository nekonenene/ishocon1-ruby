.PHONY: restart
restart:
	cd ~/webapp/ruby
	git pull
	bundle exec foreman restart

