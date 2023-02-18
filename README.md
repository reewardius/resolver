# resolveDomains

- In general, the main idea of this repo (now) is to search for Origin IP.
- Given a list of domains, you resolve them and get the IP addresses. 
- Then use ffuf to search for the Origin IP.


# Installation

If you want to make modifications locally and compile it, follow the instructions below:

```
> git clone https://github.com/reewardius/resolver.git
> cd resolveDomains
> go build

If it doesn't build -> go mod tidy && go build
```

If you are only interested in using the program:

```
> go get github.com/reewardius/resolver.git
```

# Usage

```
> subfinder -d tesla.com > subs
> resolveDomains -d subs [-t 150] [-r 8.8.8.8:53] > res
> ./test.sh
```

Don't forget the ./ in front of the program name if you are compiling locally!

# Example

![image](https://user-images.githubusercontent.com/16885065/119138781-8bbd9f00-ba42-11eb-87f8-63e38fc93e29.png)


# Origin IP

Find Origin IP.
1. subdomain enumeration.
2. Save All A records in ip_addresses.txt.
3. Remove CDN IP. (https://github.com/projectdiscovery/cdncheck)
4. Fuzz Host Header on IPs.txt with list of all subdomains.
```
> for ip in $(cat ip_addresses.txt);do echo $ip && ffuf -w ./subs -u http://$ip -H "Host: FUZZ" -s -mc 200; done
> cat ip_addresses.txt | parallel 'echo {} && ffuf -w ./subs -u http://{} -H "Host: FUZZ" -s -mc 200'
> OR cat ip_addresses.txt | xargs -I {} sh -c 'echo {} && ffuf -w ./subs -u http://{} -H "Host: FUZZ" -s -mc 200'
> OR head -n 10 ip_addresses.txt | tr '\n' ',' | sed 's/,$//' | xargs -I {} sh -c 'echo {} && ffuf -w ./subs -u http://{} -H "Host: FUZZ" -s -mc 200'
