kubectl config set-context aws --namespace jx
printf "%s\n" | jx install --provider=${jxprovider} --verbose=true  --keep-exposecontroller-job=false --install-only=true  --batch-mode=true --helm3=false --namespace=jx --default-admin-password=${admin_password} --no-default-environments=true --recreate-existing-draft-repos=false  --environment-git-owner=${git_owner} --git-username=${git_user}  --git-provider-url=${git_provider_url} --git-username=${git_user} --git-api-token=${git_token}