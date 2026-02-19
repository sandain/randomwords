RANDOMWORDS_USER := randomwords
RANDOMWORDS_GROUP := randomwords
RANDOMWORDS_HOME := /opt/randomwords
RANDOMWORDS_SERVICE := /etc/systemd/system

.PHONY: install adduser update clean

install: adduser update
	systemctl -f enable randomwords.service;

adduser:
	useradd --system --user-group --create-home -K UMASK=0022 --home $(RANDOMWORDS_HOME) $(RANDOMWORDS_USER)

update:
	install -m 0755 randomwords $(RANDOMWORDS_HOME)
	install -m 0644 words.txt $(RANDOMWORDS_HOME)
	install -m 0644 randomwords.service $(RANDOMWORDS_SERVICE);
	cp -R templates $(RANDOMWORDS_HOME)
	cp -R public $(RANDOMWORDS_HOME)
	systemctl daemon-reload

clean:
	systemctl -f disable randomwords.service;
	rm -R $(RANDOMWORDS_HOME)
