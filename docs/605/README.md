# Research into creating a docker for multiple php sites

```conf
#devel
<VirtualHost *:80>
		ServerName jared81.int.ecreativeworks.com
		DocumentRoot /data/www/webroot/devel/public_html

		CustomLog /data/www/webroot/devel/logs/devel.log combined
		ErrorLog /data/www/webroot/devel/logs/devel.errors

		#PHP settings -
		ProxyTimeout 600
		<Proxy "fcgi://devel-www/" acquire=3000 connectiontimeout=3 disablereuse=on max=20>
			#leave empty - matches the SetHandler directive

		</Proxy>

		<FilesMatch ".+\.php$">
			SetHandler "proxy:unix:/var/run/php-fpm.sockets.d/devel-www.sock|fcgi://devel-www/"
		</FilesMatch>

</VirtualHost>

#devel - SSL - SNI enabled
<VirtualHost *:443>
		ServerName jared81.int.ecreativeworks.com
		DocumentRoot /data/www/webroot/devel/public_html

		CustomLog /data/www/webroot/devel/logs/devel.log combined
		ErrorLog /data/www/webroot/devel/logs/devel.errors

		#SSL engine
		SSLEngine on
		SSLCertificateFile /usr/local/etc/bsdmanage/webman/ssl.crts/jared81.int.ecreativeworks.com.crt
		SSLCertificateKeyFile /usr/local/etc/bsdmanage/webman/ssl.crts/jared81.int.ecreativeworks.com.key
		#intermediate cert
		#SSLCACertificateFile /usr/local/etc/bsdmanage/webman/ssl.crts/jared81.int.ecreativeworks.com.ca

		#PHP settings -
		ProxyTimeout 600
		<Proxy "fcgi://devel-www/" acquire=3000 connectiontimeout=3 disablereuse=on max=20>
			#leave empty - matches the SetHandler directive

		</Proxy>

		<FilesMatch ".+\.php$">
			SetHandler "proxy:unix:/var/run/php-fpm.sockets.d/devel-www.sock|fcgi://devel-www/"
		</FilesMatch>
</VirtualHost>
```
