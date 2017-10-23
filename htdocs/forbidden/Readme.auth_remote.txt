README mod_auth_remote  ( Apache 2.0 authentication module )

This module is a very simple, lightweight method of setting up a single signon
system across multiple web-applicaitions hosted on different servers.

The actual authentication & authorization system is deployed on a single server
instead of each individual server. All other servers are built with 
mod_auth_remote enabled. When a request comes in, mod_auth_remote obtains the
client username & password from the client via basic authentication scheme.

It then builds a HTTP header with authorization header built from the client's
userid:passwd. mod_auth_remote then makes a HEAD request to the authentication
server. On reciept of a 2XX response, the client is validated; for all other
responses the client is not validated.

Why I wrote mod_auth_remote ?

I have a bunch of web applications running on a bunch of machines ...

1) My authentication code is heavy & I don't want to implement it on all 
   of your servers. (I use mod_perl and require a Database access to 
   authenticate)

2) Most of  my web applications use a single signon

3) Two different applications running under the same server could access 2
   different authentication models without any pain 

-- ok, no more marketing :-)  ------

I enabled mod_auth_remote on my httpd like this ...

1) cp mod_auth_remote.c modules/experimental/mod_auth_remote.c
2) apply patch 'auth_remote.patch' on 'configure' script.
3) ./configure --disable-auth --enable-auth_remote 

'httpd -l' should show mod_auth_remote.c
------------------------------------------

My conf file looks like ...


<Directory ~ "/application_1/">
 AuthType           Basic
 AuthName           CHICKEN_RUN
 AuthRemoteServer   auth1.saju.com
 AuthRemotePort     80
 AuthRemoteURL      /One/Auth/method
 require            valid-user
</Directory>

<Directory ~ "/application_2/">
 AuthType           Basic
 AuthName           BIG-CHIEF
 AuthRemoteServer   auth1.saju.com
 AuthRemotePort     80
 AuthRemoteURL      /luke/takes/a/walk
 require            valid-user
</Directory>

<Directory ~ "/application_3/">
 AuthType           Basic
 AuthName           ONE_RING
 AuthRemoteServer   sauron.saju.com
 AuthRemotePort     80
 AuthRemoteURL      /auth
 require            valid-user
</Directory>

---------------------------------------------------

srp@symonds.net

