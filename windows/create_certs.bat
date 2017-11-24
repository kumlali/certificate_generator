@echo off
rem ------------------------------------------------------------------
rem Requirements: 
rem  * openssl (We used OpenSSL 1.0.2m - 2 Nov 2017 - Win64)
rem  * keytool (We used JDK 1.8.0_66-b18)
rem ------------------------------------------------------------------


rem ------------------------------------------------------------------
rem Following variables must be set before running the script
rem ------------------------------------------------------------------

rem openssl's path. If openssl is already in PATH, then
rem OPENSSL=openssl can be used.
set OPENSSL=openssl

rem keytool's path. If keytool is already in PATH, then 
rem KEYTOOL=keytool can be used.
set KEYTOOL=keytool

rem The password to be used in all key & stores.
set PASSWORD=pa$$wOrD

rem Alias for PKCS12 and JKS key store.
set DOMAIN_ALIAS=%RANDOM%


rem ------------------------------------------------------------------
rem CA and domain key and certificate generation
rem ------------------------------------------------------------------

rem Do not fail if directories already exist
mkdir ca  > nul 2> nul
mkdir domain  > nul 2> nul

echo ---------------------------------------------------------------
echo CA: Private key is being created...
echo ---------------------------------------------------------------
%OPENSSL% genrsa -aes256 -passout pass:%PASSWORD% -out ca/ca.key.pem 4096 

echo ---------------------------------------------------------------
echo CA: Certificate is being created...
echo ---------------------------------------------------------------
%OPENSSL% req -config openssl.cnf -new -x509 -days 18250 -sha256 -extensions v3_ca -key ca/ca.key.pem -passin pass:%PASSWORD% -out ca\ca.cert.pem

echo ---------------------------------------------------------------
echo Domain: Private key is being created...
echo ---------------------------------------------------------------
%OPENSSL% genrsa -out domain\domain.key.pem 2048 

echo ---------------------------------------------------------------
echo Domain: Certificate signing request(CSR) is being created...
echo ---------------------------------------------------------------
%OPENSSL% req -config openssl.cnf -new -sha256 -key domain\domain.key.pem -out domain\domain.csr.pem

echo ---------------------------------------------------------------
echo Domain: CSR is being signed with CA key...
echo ---------------------------------------------------------------
%OPENSSL% x509 -req -extfile openssl.cnf -extensions multipurpose_cert -days 18250 -set_serial %RANDOM% -in domain\domain.csr.pem -passin pass:%PASSWORD% -CAkey ca\ca.key.pem -CA ca\ca.cert.pem -out domain\domain.cert.pem

echo ---------------------------------------------------------------
echo Domain: PKCS12 key store is being created...
echo ---------------------------------------------------------------
rem %OPENSSL% pkcs12 -export -name %DOMAIN_ALIAS% -inkey domain\domain.key.pem -in domain\domain.cert.pem -passout pass:%PASSWORD% -out domain\domain.p12
%OPENSSL% pkcs12 -export -inkey domain\domain.key.pem -in domain\domain.cert.pem -passout pass:%PASSWORD% -out domain\domain.p12

echo ---------------------------------------------------------------
echo Domain: JKS key store is being created from PKCS12 key store...
echo ---------------------------------------------------------------
%KEYTOOL% -importkeystore -srcstoretype pkcs12 -srckeystore domain\domain.p12 -srcstorepass %PASSWORD% -deststoretype JKS -destkeystore domain\domain.jks -deststorepass %PASSWORD%

echo ---------------------------------------------------------------
echo Cleaning up unnecessary files...
echo ---------------------------------------------------------------
del domain\domain.csr.pem