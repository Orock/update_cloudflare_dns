# Actualiza los DNS de Cloudfire

### Uso en cron 

```
15 * * * * CLOUDFLARE_TOKEN="{CLOUDFLARE_TOKEN}" CLOUDFLARE_ZONE_ID="{CLOUDFLARE_ZONE_ID}" CLOUDFLARE_DNS_RECORD_ID="{CLOUDFLARE_DNS_RECORD_ID}" CLOUDFLARE_DOMAIN_NAME="{CLOUDFLARE_DOMAIN_NAME}" /path/to/update_dns.sh

```

### Documentación de la API
https://api.cloudflare.com