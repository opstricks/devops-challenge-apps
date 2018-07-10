kubectl config set-context aws --namespace jx
jx create jenkins token  -p "${admin_password}" ${admin_user} ; jx create git token --name GitHub -t ${git_token} ${git_user}
kubectl delete secret jenkins-docker-cfg
kubectl create secret generic jenkins-docker-cfg --from-file=./config.json