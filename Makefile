

all: dist-prep download
	./build.pl --maxjobs 8
	rsync -az work/. /var/www/beta.test-ipv6.com/. --exclude site --delete --progress 
	- test -f /Applications/Safari.app/Contents/MacOS/Safari && open http://beta.test-ipv6.com/

beta: dist-prep download
	./build.pl --locale en_US --config beta.inc
	rsync -az work/. /var/www/beta.test-ipv6.com/. --exclude site --delete --progress
	- test -f /Applications/Safari.app/Contents/MacOS/Safari && open http://beta.test-ipv6.com/isp/

download:
	cd po && ./download.pl


dist-prep: work
	rm -fr work
	mkdir -p work/images
	mkdir -p work/images-nc
	rsync -a images/. work/images/.
	rsync -a images/. work/images-nc/.

dist-test: work
	 ../dist_support/make-dist.pl --base content --branch test

dist-stable: work
	 ../dist_support/make-dist.pl --base content --branch stable

