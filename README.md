<h2 align= "center">SSL/TLS</h2>

---

<div align= "center"><b>Enable Encrypted data sharing (HTTPS) between browsers/servers in the web.</div></b>

<h3 style="text-shadow: 2px 1px darkgreen; color: white; text-align: left; text-decoration: underline;"> 
SSL Certificates:</h3>

<i><b>If your enterprise is planning to release a [Digitally Signed Software](https://en.wikipedia.org/wiki/Code_signing#cite_note-baselinereq-18), use the following steps to request an [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) encryption to a valid and trusted [Certificate Authority (CA)](https://cabforum.org/working-groups/code-signing/#members) to transmit encoded digital signatures using [SSL/TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security) translated into [HTTPs](https://en.wikipedia.org/wiki/HTTPS) in an organization's domain. </i></b>

To secure a domain with [HTTPS](https://en.wikipedia.org/wiki/HTTPS), client and server [Certificate Signing Requests](https://en.wikipedia.org/wiki/Certificate_signing_request) [`csr`](https://github.com/EstebanMqz/SSL-HTTPS/blob/main/.gitignore) must be issued.


<div style="font-size:13px">

### .crt

The [`.crt`](https://docs.fileformat.com/web/crt/) files are [X.509](https://en.wikipedia.org/wiki/X.509) certificates, used for [SSL/TLS](https://en.wikipedia.org/wiki/Transport_LayerSecurity#Description) sessions & they can be binary [ASN.1 DER](https://learn.microsoft.com/en-us/windows/win32/seccertenroll/about-der-encoding-of-asn-1-types) or [Base-64 (PEM)](www.redhat.com/sysadmin/base64-encoding) encoded.


### .key
The [`.key`](https://www.ibm.com/docs/en/connect-direct/6.1.0?topic=files-key-file-format) file contains a private key.<br> Several formats are used like [<b>DER, PKCS#7, PKCS#12, & usually PEM](https://www.ssl.com/guide/pem-der-crt-and-cer-x-509-encodings-and-conversions/)</b>.<br><br>
<i>The key is used for the creation of [CSR](ttps://en.wikipedia.org/wiki/Certificate_signing_request) Certificate Signing Requests & secure handling of cryptographic [SSL/TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security) for [IMAP](https://support.microsoft.com/en-us/office/what-are-imap-and-pop-ca2c5799-49f9-4079-aefe-ddca85d5b1c9), [SMTP](https://try.smtp.com/email-marketing/), [FTPS](https://en.wikipedia.org/w/index.php?title=FTPS&action=view&section=5#General_support), [SIP](https://en.wikipedia.org/wiki/Session_Initiation_Protocol), [VOIP](en.wikipedia.org/wiki/Voice_over_IP) calls & [LDAP](https://ldap.com) as well as 
[HTTPs](https://en.wikipedia.org/wiki/HTTPS) enabled domains as they are used to encrypt & decrypt data sent between the server and the client.</i>

### .csr
<i>The [`.csr`](https://en.wikipedia.org/wiki/Sparse_matrix) ext & it's a block of encoded text that is given to a [.csr](ttps://en.wikipedia.org/wiki/Certificate_signing_request) file to apply for an SSL Certificate.<br>
It is usually generated on the server where the certificate will be installed and contains info from the certificate such as:</i>


+ Organization Name (website domain name) <i>blank if it's an individual</i>.
+ Common name (legal name) for [Organization Validation](https://en.wikipedia.org/wiki/Public_key_certificate#Validation_types) OV & EV [Extended Validation](https://en.wikipedia.org/wiki/Extended_Validation_Certificate) certificates.
+ Locality & Country.
+ Email address.



1. Create subdirs. [.crt, .key & .csr](https://github.com/EstebanMqz/SSL-HTTPS/blob/main/.gitignore). <br><i>(mine are being <b>.gitignored</b> as they are private</i> &#128521;.

```bash
mkdir .crt .key .csr && ./CA_CSR.sh #Create subdirs.
```
<br>

Run [CA_CSR.sh](https://github.com/EstebanMqz/SSL-HTTPS/blob/main/CA_CSR.sh)

1. Select a [CA](https://cabforum.org/working-groups/code-signing/#members)
The most common are 
- [Comodo](https://www.comodo.com) and prices range from $64.95 to $359.95.
- [DigiCert](https://www.digicert.com) and prices range from $218 to $995.
- [Entrust](https://www.entrust.com) and prices range from $174 to $1,499.
- [GeoTrust](https://www.geotrust.com) and prices range from $149 to $299.
- [GlobalSign](https://www.globalsign.com) and prices range from $249 to $1,499.
- [Let's Encrypt](https://letsencrypt.org) and it's free.

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) from the [NCSA](https://www.ncsa.illinois.edu) funded by the [NSF](https://en.wikipedia.org/wiki/National_Science_Foundation).<br>
©  Copyright 2024 [EstebanMqz](https://github.com/EstebanMqz) for [SSL-HTTPS](https://github.com/EstebanMqz/SSL-HTTPS) repository.
