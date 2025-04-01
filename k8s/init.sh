terraform init \
    -backend-config="bucket=${VAR_TFSTATE_BUCKET}" \
    -backend-config="key=${VAR_TFSTATE_KEY}" \
    -backend-config="endpoint=${VAR_TFSTATE_ENDPOINT}" \
    -backend-config="access_key=${SECRET_TFSTATE_ACCESS_KEY}" \
    -backend-config="secret_key=${SECRET_TFSTATE_SECRET_KEY}"