
# API --------------------------------------------
# application import
rm -rfv api/.git
jx import api --name='api' --pack='api' --git-username=${git_user} --git-provider-url=${git_provider_url} --git-api-token=${git_token} --default-owner=${git_owner}  --org=${git_organization}  --verbose=true --no-draft=true
# Build
jx start pipeline  ${git_user}/api/master && jx get build log   ${git_user}/api/master
# appplication promote
cd api ; jx promote --app='api' --version='0.0.2' --env='dev' --batch-mode=true ; cd ..

# WEB --------------------------------------------
# application import
rm -rfv web~/.git
jx import web --name='web' --pack='web' --git-username=${git_user} --git-provider-url=${git_provider_url} --git-api-token=${git_token} --default-owner=${git_owner}  --org=${git_organization}  --verbose=true --no-draft=true
# Build
jx start pipeline  ${git_user}/web/master && jx get build log   ${git_user}/web/master
# appplication promote
cd api ; jx promote --app='api' --version='0.0.2' --env='dev' --batch-mode=true ; cd ..
