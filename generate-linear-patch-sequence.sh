#! /bin/sh -e

releasesDir=/data/releases/nixpkgs

prev=""

for i in $(cd "$releasesDir" && ls -d nixpkgs-*pre* | sort -n); do
    if test -e "$releasesDir/$i/MANIFEST"; then
	if test -n "$prev" -a ! -e "$releasesDir/$i/.patches-created"; then
	    echo $prev "->" $i
	    date
	    time ./generate-patches.sh "$releasesDir/$prev" "$releasesDir/$i"
	    touch "$releasesDir/$i/.patches-created"
	fi
	prev=$i
    fi
done

releasesDir=/data/releases/nixos

prev=""

for i in $(cd "$releasesDir" && ls -d nixos-*pre* | sort -n); do
    if test -e "$releasesDir/$i/MANIFEST"; then
	if test -n "$prev" -a ! -e "$releasesDir/$i/.patches-created"; then
	    echo $prev "->" $i
	    date
	    time ./generate-patches.sh "$releasesDir/$prev" "$releasesDir/$i"
	    touch "$releasesDir/$i/.patches-created"
	fi
	prev=$i
    fi
done
