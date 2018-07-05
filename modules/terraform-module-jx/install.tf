resource "null_resource" "kubernetes_check" {
  provisioner "local-exec" {
    command = "export KUBECONFIG=${var.kubeconfig_dir}/kubeconfig"
  }

  provisioner "local-exec" {
    command = "${file("${path.module}/scripts/waiter_check_kubernetes.sh")}"
  }
}

data "template_file" "jx_install_create" {
  template = "${file("${path.module}/templates/resource-jx_install-create.tpl")}"

  vars {
    admin_user       = "${var.admin_user}"
    admin_password   = "${var.admin_password}"
    jxprovider       = "${var.jxprovider}"
    git_provider_url = "${var.git_provider_url}"
    git_owner        = "${var.git_owner}"
    git_user         = "${var.git_user}"
    git_token        = "${var.git_token}"
  }
}

resource "null_resource" "jx_install" {
  # triggers {  #   version = "${var.triggers}"  # }

  provisioner "local-exec" {
    command = "export KUBECONFIG=${var.kubeconfig_dir}/kubeconfig"
  }

  provisioner "local-exec" {
    command = "${data.template_file.jx_install_create.rendered}"
  }

  provisioner "local-exec" {
    command = "kubectl config set-context `kubectl config current-context` --namespace jx"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "${file("${path.module}/scripts/jx-delete.sh")}"
  }
}

resource "null_resource" "jx_check" {
  provisioner "local-exec" {
    command = "${file("${path.module}/scripts/waiter_check_jenkins-x.sh")}"
  }

  depends_on = ["null_resource.jx_install"]
}

resource "null_resource" "jx_set_ns" {
  triggers {
    kubeconfig_file = "${sha1(file("/home/peterson/.kube/kubeconfig"))}"
  }

  provisioner "local-exec" {
    command = "kubectl config set-context `kubectl config current-context` --namespace jx"
  }
}
