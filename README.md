# certificate_generator
Helper scripts to create CA and domain certificates by using OpenSSL and Java keytool

It produces:
* CA private key(password protected): `ca/ca.key.pem`
* CA certificate: `ca/ca.cert.pem`
* Domain private key: `domain/domain.key.pem`
  * We omited the password to prevent entering the password every time a web server(eg, Apache) started.
* Domain certificate: `domain/domain.cert.pem`
* Domain PKCS12 keystore(password protected): `domain/domain.p12`
* Domain JKS keystore(password protected): `domain/domain.jks`

# Usage

For Linux `create_certs.sh`, for Windows `create_certs.bat` files contain `OPENSSL`, `KEYTOOL`, `PASSWORD` and `DOMAIN_ALIAS` variables. If default values of these variables do not match your needs, you have to update them. In most cases, you will need to change at least `PASSWORD`and `DOMAIN_ALIAS`.

You will also need to update `alt_names` in `openssl.cnf`

## Linux
* Clone the project: `git clone https://github.com/kumlali/certificate_generator.git`
* Get into `certificate_generator/linux` directory: `cd certificate_generator/linux`
* Update `alt_names` in `openssl.cnf`
* (Optional) Set `OPENSSL`, `KEYTOOL`, `PASSWORD` and `DOMAIN_ALIAS` variables in `create_certs.sh`
* Give execute permission to `create_certs.sh`: `chmod +x create_certs.sh`
* Execute `create_certs.sh`:

```bash
[me@mycomputer linux]$ ./create_certs.sh
---------------------------------------------------------------
CA: Private key is being created...
---------------------------------------------------------------
Generating RSA private key, 4096 bit long modulus
..................................................................................................................................................................................................................................................++
...........++
e is 65537 (0x10001)
---------------------------------------------------------------
CA: Certificate is being created...
---------------------------------------------------------------
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Organization Name (company) []:My Company
Organizational Unit Name (department, division) []:Security Department
Email Address []:security@mycompany.com
Locality Name (city, district) []:Besiktas
State or Province Name (full name) []:Istanbul
Country Name (2 letter code) []:TR
Common Name (hostname, IP, or your name) []:My Company Certificate Service
---------------------------------------------------------------
Domain: Private key is being created...
---------------------------------------------------------------
Generating RSA private key, 2048 bit long modulus
...................+++
.........................+++
e is 65537 (0x10001)
---------------------------------------------------------------
Domain: Certificate signing request(CSR) is being created...
---------------------------------------------------------------
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Organization Name (company) []:My Company
Organizational Unit Name (department, division) []:My Department
Email Address []:mydepartment@mycompany.com
Locality Name (city, district) []:Besiktas
State or Province Name (full name) []:Istanbul
Country Name (2 letter code) []:TR
Common Name (hostname, IP, or your name) []:*.mycompany.com
---------------------------------------------------------------
Domain: CSR is being signed with CA key...
---------------------------------------------------------------
Signature ok
subject=/O=My Company/OU=My Department/emailAddress=mydepartment@mycompany.com/L=Besiktas/ST=Istanbul/C=TR/CN=*.mycompany.com
Getting CA Private Key
---------------------------------------------------------------
Domain: PKCS12 key store is being created...
---------------------------------------------------------------
---------------------------------------------------------------
Domain: JKS key store is being created from PKCS12 key store...
---------------------------------------------------------------
Importing keystore domain/domain.p12 to domain/domain.jks...
Entry for alias *.mycompany.com successfully imported.
Import command completed:  1 entries successfully imported, 0 entries failed or cancelled

Warning:
The JKS keystore uses a proprietary format. It is recommended to migrate to PKCS12 which is an industry standard format using "keytool -importkeystore -srckeystore domain/domain.jks -destkeystore domain/domain.jks -deststoretype pkcs12".
---------------------------------------------------------------
Cleaning up unnecessary files...
---------------------------------------------------------------
[me@mycomputer linux]$ ls ca domain
ca:
ca.cert.pem  ca.key.pem

domain:
domain.cert.pem  domain.jks  domain.key.pem  domain.p12
[me@mycomputer linux]$
```

## Windows

* Clone the project: `git clone https://github.com/kumlali/certificate_generator.git`
* Get into `certificate_generator\windows` directory: `cd certificate_generator\windows`
* Update `alt_names` in `openssl.cnf`
* (Optional) Set `OPENSSL`, `KEYTOOL`, `PASSWORD` and `DOMAIN_ALIAS` variables in `create_certs.bat`
* Execute `create_certs.bat`:

```bat
c:\certificate_generator\windows>create_certs.bat
---------------------------------------------------------------
CA: Private key is being created...
---------------------------------------------------------------
Loading 'screen' into random state - done
Generating RSA private key, 4096 bit long modulus
........................................................................................................................
.............................................++
........................................................................................................................
........................................................................................................................
......................++
unable to write 'random state'
e is 65537 (0x10001)
---------------------------------------------------------------
CA: Certificate is being created...
---------------------------------------------------------------
Loading 'screen' into random state - done
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Organization Name (company) []:My Company
Organizational Unit Name (department, division) []:Security Department
Email Address []:security@mycompany.com
Locality Name (city, district) []:Besiktas
State or Province Name (full name) []:Istanbul
Country Name (2 letter code) []:TR
Common Name (hostname, IP, or your name) []:My Company Certificate Service
---------------------------------------------------------------
Domain: Private key is being created...
---------------------------------------------------------------
Loading 'screen' into random state - done
Generating RSA private key, 2048 bit long modulus
........................................................................................................................
.......................+++
.................................................+++
unable to write 'random state'
e is 65537 (0x10001)
---------------------------------------------------------------
Domain: Certificate signing request(CSR) is being created...
---------------------------------------------------------------
Loading 'screen' into random state - done
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Organization Name (company) []:My Company
Organizational Unit Name (department, division) []:My Department
Email Address []:mydepartment@mycompany.com
Locality Name (city, district) []:Besiktas
State or Province Name (full name) []:Istanbul
Country Name (2 letter code) []:TR
Common Name (hostname, IP, or your name) []:*.mycompany.com
---------------------------------------------------------------
Domain: CSR is being signed with CA key...
---------------------------------------------------------------
Loading 'screen' into random state - done
Signature ok
subject=/O=My Company/OU=My Department/emailAddress=mydepartment@mycompany.com/L=Besiktas/ST=Istanbul/C=TR/CN=*.mycompan
y.com
Getting CA Private Key
unable to write 'random state'
---------------------------------------------------------------
Domain: PKCS12 key store is being created...
---------------------------------------------------------------
Loading 'screen' into random state - done
unable to write 'random state'
---------------------------------------------------------------
Domain: JKS key store is being created from PKCS12 key store...
---------------------------------------------------------------
Entry for alias 1 successfully imported.
Import command completed:  1 entries successfully imported, 0 entries failed or cancelled
---------------------------------------------------------------
Cleaning up unnecessary files...
---------------------------------------------------------------

c:\certificate_generator\windows>dir ca domain
 Volume in drive C is OS
 Volume Serial Number is 0CC4-6E8B

 Directory of c:\certificate_generator\windows\ca

24.11.2017  11:23    <DIR>          .
24.11.2017  11:23    <DIR>          ..
24.11.2017  11:23             2.256 ca.cert.pem
24.11.2017  11:21             3.326 ca.key.pem
               2 File(s)          5.582 bytes

 Directory of c:\certificate_generator\windows\domain

24.11.2017  11:24    <DIR>          .
24.11.2017  11:24    <DIR>          ..
24.11.2017  11:24             2.472 domain.cert.pem
24.11.2017  11:24             3.132 domain.jks
24.11.2017  11:23             1.679 domain.key.pem
24.11.2017  11:24             3.381 domain.p12
               4 File(s)         10.664 bytes
               2 Dir(s)  239.961.702.400 bytes free

c:\certificate_generator\windows>
```