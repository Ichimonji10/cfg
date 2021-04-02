# https://docs.gandi.net/en/ssl/common_operations/index.html
# https://www.gnu.org/software/make/manual/make.html#Pattern-Rules

.PHONY: chained-certs
chained-certs: \
	funkwhale.jerebear.name.chained.crt \
	transmission.jerebear.name.chained.crt \
	www.jerebear.name.chained.crt \
	www.backtobasicsreading.com.chained.crt

%.chained.crt: %.crt GandiStandardSSLCA2.pem
	cat $^ > $@

.PHONY: clean
clean:
	rm -f *.chained.crt
