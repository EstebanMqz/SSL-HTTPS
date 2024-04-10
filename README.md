<h2 align= "center">SSL/TLS (HTTPs)</h2>

---

<div align= "center"><b>Enable Encrypted data sharing (HTTPS) between browsers/servers in the web.</div></b>

<h3 style="text-shadow: 2px 1px darkgreen; color: white; text-align: left; text-decoration: underline;"> 
SSL Certificates:</h3>

<i><b>If your enterprise is planning to release a [Digitally Signed Software](https://en.wikipedia.org/wiki/Code_signing#cite_note-baselinereq-18), use the following steps to request an [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) encryption to a valid and trusted [Certificate Authority (CA)](https://cabforum.org/working-groups/code-signing/#members) to transmit encoded digital signatures using [SSL/TLS](https://en.wikipedia.org/wiki/Transport_Layer_Security) translated into [HTTPs](https://en.wikipedia.org/wiki/HTTPS) in an organization's domain. </i></b>

To secure a domain with [HTTPS](https://en.wikipedia.org/wiki/HTTPS), client and server [Certificate Signing Requests](https://en.wikipedia.org/wiki/Certificate_signing_request) must be issued.


### .crt
<div style="font-size:14px">

The [`.crt`](https://docs.fileformat.com/web/crt/) files are [X.509](https://en.wikipedia.org/wiki/X.509) certificates, used for [SSL/TLS](https://en.wikipedia.org/wiki/Transport_LayerSecurity#Description) sessions & they can be binary [ASN.1 DER](https://learn.microsoft.com/en-us/windows/win32/seccertenroll/about-der-encoding-of-asn-1-types) or [Base-64 encoded (PEM)](www.redhat.com/sysadmin/base64-encoding#:~:text=The%20Base64-encoded%20certificate%20structure,decoding%20the%20Base64-encoded%20data).


### .key
The [`.key`](https://www.ibm.com/docs/en/connect-direct/6.1.0?topic=files-key-file-format) file contains a private key.<br> Several formats are used like [<b>DER, PKCS#7, PKCS#12, & usually PEM](https://www.ssl.com/guide/pem-der-crt-and-cer-x-509-encodings-and-conversions/)</b>.<br>
<i>They key is used in [CSR](ttps://en.wikipedia.org/wiki/Certificate_signing_request) and the secure handling of [SSL/TLS]() connections.</i>

### .csr
The [`.csr`](https://en.wikipedia.org/wiki/Sparse_matrix) extension is used for Certificate Signing Request files and it's a block of encoded text that is given to a Certificate Authority when applying for an SSL Certificate. It is usually generated on the server where the certificate will be installed and contains info from the certificate such as the organization name, common name (domain name), locality, and country. It also contains the public key that will be included in the certificate.
1.  Create subirs. ".crt", ".key" and ".csr" <i>(mine are being <b>.gitignored</b> as they are meant to be private)</i></div>

```bash
mkdir .crt .key .csr && ./CA_CSR.sh #Create subdirs.
```

Run [`CA_CSR.sh`](github.com/EstebanMqz/SSL-HTTPS/blob/main/CA_CSR.sh}

1. Select a Certificate Authority (CA), such as DigiCert, Comodo, or Let's Encrypt.
2. Generate a Certificate Signing Request (CSR) on your web server, which includes your company and domain name details.
3. Submit the CSR and additional information about your organization and domain to the CA.
4. The CA verifies your information, including domain control and potentially your organization's identity.
5. Install the issued certificate on your web server.
6. Configure your website to use HTTPS instead of HTTP, usually by updating your website's configuration file.
<br><br>

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) from the [NCSA](https://www.ncsa.illinois.edu) funded by the [NSF](https://en.wikipedia.org/wiki/National_Science_Foundation).<br>
©  Copyright 2024 [EstebanMqz](https://github.com/EstebanMqz) developed in [SSL-HTTPS](https://github.com/EstebanMqz/SSL-HTTPS).
