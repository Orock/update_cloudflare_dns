# Actualiza los DNS de Cloudfire

### Uso en cron 

```
15 * * * * CLOUDFLARE_API_TOKEN="{CLOUDFLARE_API_TOKEN}" CLOUDFLARE_ZONE_ID="{CLOUDFLARE_ZONE_ID}" CLOUDFLARE_DNS_RECORD_ID="{CLOUDFLARE_DNS_RECORD_ID}" CLOUDFLARE_DOMAIN_NAME="{CLOUDFLARE_DOMAIN_NAME}" /path/to/update_dns.sh

```

### Para obtener variables
```
curl -X GET "https://api.cloudflare.com/client/v4/zones/{CLOUDFLARE_ZONE_ID}/dns_records" \
     -H "Authorization: Bearer {CLOUDFLARE_API_TOKEN}" \
     -H "Content-Type: application/json"
```


### Documentación de la API
https://api.cloudflare.com

