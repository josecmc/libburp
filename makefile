all:
	d.compile -o libburp_c.a -src burp_api.c -O 3
	d.compile -o libburp_c_shared.so -src burp_api.c
