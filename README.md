# tiny (only 4.28 MB) cntlm docker image based on Alpine Linux

Use the following environment variables for configuration:

- `CNTLM_PROXY` (**mandatory**): address of the upstream proxy (example: proxy.example.com:89)
- `CNTLM_NO_PROXY` (*optional*): addresses and hostnames to bypass the proxy: (default: localhost, 127.0.0.\*, 10.\*, 192.168.\*)
- `CNTLM_USERNAME` (*optional*): username to login to the upstream proxy
- `CNTLM_DOMAIN`   (*optional*): domain to login to upstream proxy

For authentication one or multiple of the following passwords can be set:

- `CNTLM_AUTH` (*optional*): authentication type (default: NTLMv2)
- `CNTLM_PASSWORD` (*optional*): plain text password to login to upstream proxy
- `CNTLM_PASSNTLMV2` (*optional*): NTLMv2 password to login to upstream proxy
- `CNTLM_PASSNT` (*optional*): PassNt password to login to upstream proxy
- `CNTLM_PASSLM` (*optional*): PassLM password to login to upstream proxy

Usages examples : 

 * Simple example without authentication
   * `docker run -it --rm --name mycntlm -e CNTLM_PROXY=myproxy:8080 camandel/cntlm`
 * With NTLMv2 authentication 
   * `docker run -it --rm --name mycntlm -e CNTLM_PROXY=myproxy:8080 -e CNTLM_USERNAME=myuser -e CNTLM_PASSWORD=mypassword camandel/cntlm`
 * Discover best authentication available and hashes 
   * `docker run -it  --rm -e CNTLM_PROXY=myproxy:8080 -e CNTLM_USERNAME=myuser -e CNTLM_DOMAIN=mydomain camandel/cntlm "-H -M http://www.example.com"                                                                                                                               
    cntlm: Starting cntlm version 0.92.3 for LITTLE endian
    cntlm: Proxy listening on 0.0.0.0:3128
    cntlm: Workstation name used: 309cedf15530
    Password: ************************
    cntlm: Using proxy myproxy:8080
    cntlm: No target info block. Cannot do NTLMv2!
    Config profile  1/4... Credentials rejected
    Config profile  2/4... OK (HTTP code: 302)
    ----------------------------[ Profile  1 ]------
    Auth            NTLM
    PassNT          xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    PassLM          yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
    ------------------------------------------------
    cntlm: Terminating with 0 active threads`
* With NTLM authentication and password hashes
  * `docker run -d  --name mycntlm -p 3128:3128 -e CNTLM_PROXY=myproxy:8080 -e CNTLM_USERNAME=myuser -e CNTLM_DOMAIN=mydomain -e CNTLM_AUTH=NTLM -e CNTLM_PASSNT=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -e CNTLM_PASSLM=yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy cntlm`
  
Additonal parameters to cntlm can be passwd ass argument to the container.
