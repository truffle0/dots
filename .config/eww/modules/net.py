#!/bin/env python
import sys
from time import sleep
import json

from psutil import net_if_addrs, net_if_stats
from socket import AddressFamily

if __name__ == "__main__":
    stats = net_if_stats()
    addrs = net_if_addrs()

    output = {}
    output["interfaces"] = []
    for name, info in stats.items():
        if info.isup and 'loopback' not in info.flags.split(','):
            ipv4 = [i.address for i in addrs[name] if i.family == AddressFamily.AF_INET]
            ipv6 = [i.address for i in addrs[name] if i.family == AddressFamily.AF_INET6]

            try:
                output['interfaces'].append({
                    'ifname': name,
                    'addr': ipv4[0] if len(ipv4) else ipv6[0]
                })
            except AttributeError:
                continue
    
    output['connected'] = len(output['interfaces']) > 0
    print(json.dumps(output), flush=True, file=sys.stdout)