data "template_file" "kubernetes_waiter" {
  template = "${file("${path.module}/scripts/waiter_kubernetes.sh")}"
}

resource "null_resource" "kubernetes_check" {
  provisioner "local-exec" {
    command = "${data.template_file.kubernetes_waiter.rendered}"
  }
}

resource "null_resource" "cluster" {
  triggers {
    version = "${var.triggers}"
  }

  provisioner "local-exec" {
    command = "kubectl --kubeconfig ~/.kube/kubeconfig apply  -f ${path.module}/manifests/"
  }

  depends_on = ["null_resource.kubernetes_check"]
}
