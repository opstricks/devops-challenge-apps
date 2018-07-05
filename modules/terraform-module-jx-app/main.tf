resource "null_resource" "kubernetes_check" {
  provisioner "local-exec" {
    command = "export KUBECONFIG=${var.kubeconfig_dir}/kubeconfig"
  }

  provisioner "local-exec" {
    command = "kubectl config set-context `kubectl config current-context` --namespace jx"
  }

  # provisioner "local-exec" {
  #   command = "${path.module}/scripts/waiter_check_jenkins-x.sh"
  # }
}
