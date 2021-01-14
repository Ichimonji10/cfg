# https://docs.gandi.net/en/ssl/common_operations/index.html
# https://www.gnu.org/software/make/manual/make.html#Pattern-Rules

.PHONY: chained-crts
chained-certs: my-nginx/ssl/www.backtobasicsreading.com.chained.crt my-nginx/ssl/www.jerebear.name.chained.crt

%.chained.crt: %.crt my-nginx/ssl/GandiStandardSSLCA2.pem
	cat $^ > $@

.PHONY: clean
clean:
	rm -f my-nginx/ssl/*.chained.crt
