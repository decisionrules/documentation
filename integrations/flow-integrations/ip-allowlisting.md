# IP Allowlisting

Integration Flow jobs run on dedicated infrastructure with fixed IP addresses, which are used for all outgoing connections. If your database or internal services restrict incoming traffic based on IP, these addresses must be explicitly allowed.

Make sure the required addresses are added to your allowlist before enabling the integration. The following IP addresses need to be included:

```
18.153.146.109
3.126.127.6
```

In CIDR notation:

```
18.153.146.109/32
3.126.127.6/32
```

{% hint style="info" %}
Decision Flow does not have fixed IPs — rule evaluation is distributed across dynamically scaled servers. IP whitelisting is therefore only supported for **Integration Flow**.
{% endhint %}
