terraform init \
    -backend-config="bucket=${ENV_TFSTATE_BUCKET}" \
    -backend-config="key=${ENV_TFSTATE_KEY}" \
    -backend-config="endpoint=${ENV_TFSTATE_ENDPOINT}" \
    -backend-config="access_key=${SECRET_TFSTATE_ACCESS_KEY}" \
    -backend-config="secret_key=${SECRET_TFSTATE_SECRET_KEY}"