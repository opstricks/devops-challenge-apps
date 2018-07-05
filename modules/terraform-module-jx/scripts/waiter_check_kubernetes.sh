echo -e "\033[1;36m Waiting Kubernetes check..."
while ! `kubectl get nodes &> /dev/null` ; do
  sleep 30
done
echo -e "\033[1;36m Kubernetes OK "