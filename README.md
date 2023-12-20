## **About this tool/script**
Usage: ```check domain.tld``` to lookup relevant DNS, WHOIS and SSL information in your terminal.

<kbd>
  <img src="https://github.com/zhk3r/check/assets/37957791/45595ed8-8460-4e7a-9a24-b6a66f0e067e">
</kbd>

## **Installation and setup**
| Copy-paste this                                      | Where                                         |
| :----------------------------------------------------|:----------------------------------------------|
| ```export PATH="check:$PATH"```                      | Add to your .zshrc or equivalent.             |
| ```source ~/check/check_function.zsh```              | Add to your .zshrc or equivalent.             |
| ```git clone https://github.com/zhk3r/check.git```   | to clone this repo.                           |
| ```chmod +x ~/check/update_check.sh```               | to make the update script run.                |
| ```exec zsh```                                       | Restart your terminal or shell                |

> If you're feeling epseically lazy you can copy paste this string: (assumes you use zsh+omz)
<pre lang="bash">
sudo apt install lolcat && sudo apt install python3 && sudo apt install whois && git clone https://github.com/zhk3r/check.git && chmod +x ~/check/update_check.sh && echo 'export PATH="check:$PATH"' >> ~/.zshrc && exec zsh
</pre>

## **Lookup relevant domain information**

```check domain.tld``` will first:

<details>
  <summary>Check for 'status: NXDOMAIN' in the header information</summary>
this status indicates that the domain does not exist, the script will stop here.
</details>
<details>
  <summary>Check if the domain is in QUARANTINE</summary>
if the Start of Authority is charm.norid.no; a whois (domain.tld) will be performed. if the whois returns with anything but 'No match' the domain exists but is in quarantine.
</details>

- [x] **Passing the checks the script looks for:**

| What    | Content   |  Explanation                                      |
| :-------|:----------|:--------------------------------------------------|
| RECORD  | A         | A records - IPv4 addresses.                       |
| RECORD  | AAAA      | AAAA records - IPv6 addresses.                    |
| FORWARD | HTTP      | HTTP-STATUS (301, 302, 307...) forwarding         |
| FORWARD | REDIR     | DNS redir TXT based fowarding                     |
| FORWARD | PARKED    | TXT containing ```parked```                       |
| RECORD  | MX        | MX records                                        |
| RECORD  | SPF       | Looks for SPF in ```TXT``` and ```SPF``` records  |
| RECORD  | NS        | Nameservers                                       |
| RECORD  | PTR       | Reverse DNS lookup of the domains A and AAAA IP's |
| WHOIS   | REGISTRAR | WHOIS to pull the registrar name                  |
| CURL    | SSL CERT  | Curls with and without insecure flag to check SSL |

## Secondary functions

<pre lang="bash">checkcert</pre>

Allows you to see more information about the SSL certificate, this function uses curl.

<pre lang="bash">checkssl</pre>

Allows you to see more the certificate chain and more information, this function uses openssl.

<pre lang="bash">digx</pre>

This just extracts the IP from the A record and looks up PTR, allows for no flags.

### **Output and sanitazion of information**

There are quite a few 'hidden' checks that happen during the script, it stores certain information in temporary files for use later. The logic is far from perfect, but for the most part in my own testing the output is sanitized OK. A lot of it in regards to reverse-dns lookups and registrar name conversions.

### **Dependencies**

In order for the script to run you will need the following:

| Name    | Command                        | Why
| :-------| :------------------------------| :----------------------------------------|
| python3 | ```sudo apt install python3``` | Used for reverse dns lookup logic        |
| dig     | ```sudo apt install dig```     | Used for most dns commands               |
| whois   | ```sudo apt install whois```   | Used to lookup registrar information     |
| openssl | ```sudo apt install openssl``` | Used to test SSL connectivity            |
| curl    | ```sudo apt install curl```    | Used to test SSL connectivity            |
| lolcat  | ```sudo apt install lolcat```  | Used to color some output                |

<br>

> You probably have most of these already, you could remove lolcat from line 111 if you so desire.
