# remove existing container
docker rm -f ms-web-mrjb

# variables
$VERSION = 'dev'

# app config
$connectionString = ''
$labelFilter = 'MS-WEB-MRJB'
$tenantId = ''
$clientId = ''
$clientSecret = ''
$azKeyVaultCertUri = 'https://keyvault-name.vault.azure.net/'

# docker run (use cert locally only)
docker run -d -p 8080:8080 `
						  -e ASPNETCORE_ENVIRONMENT=Development `
						  -e AZ_APPCONFIG_CONNECTION_STRING=$connectionString `
						  -e AZ_TENANT_ID=$tenantId `
						  -e AZ_APPCONFIG_LABEL_FILTER=$labelFilter `
						  -e AAD_CLIENT_ID=$clientId `
						  -e AAD_CLIENT_SECRET=$clientSecret `
						  -e AZ_KEYVAULT_CERT_URI=$azKeyVaultCertUri `
						  --name ms-web-mrjb `
						  -v $PWD/certs/:/certs/ `
						  mrjb/ms-web-mrjb:$VERSION

# list
docker ps -a | findstr mrjb

docker logs -f ms-web-mrjb