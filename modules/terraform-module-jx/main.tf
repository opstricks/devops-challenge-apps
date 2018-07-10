resource "null_resource" "kubernetes_check" {
  provisioner "local-exec" {
    command = "${data.template_file.kubernetes_check.rendered}"
  }

  depends_on = ["null_resource.depends_module_eks"]
}

resource "null_resource" "jx_prep_install" {
  # configuration git for jx
  provisioner "local-exec" {
    command = "git config --global user.email ${var.git_email}"
  }

  provisioner "local-exec" {
    command = "git config --global user.name ${var.git_user}"
  }

  provisioner "local-exec" {
    command = "git config --global credential.helper cache --replace-all"
  }
}

resource "null_resource" "jx_install" {
  # installation jx
  provisioner "local-exec" {
    command = "${data.template_file.jx_install_create.rendered}"
  }

  # delete jx
  provisioner "local-exec" {
    when    = "destroy"
    command = "${file("${path.module}/scripts/jx-delete.sh")}"
  }

  depends_on = ["null_resource.kubernetes_check", "null_resource.jx_prep_install", "null_resource.depends_module_eks"]
}

resource "null_resource" "jx_check" {
  # provisioner "local-exec" {  #   command = "export KUBECONFIG=${var.kubeconfig_dir}/kubeconfig"  # }

  provisioner "local-exec" {
    command = "${data.template_file.jenkins_x_check.rendered}"
  }

  depends_on = ["null_resource.jx_install"]
}

# resource "null_resource" "jx_post_install" {
#   provisioner "local-exec" {
#     command = "kubectl get secret jenkins-docker-cfg && kubectl delete secret jenkins-docker-cfg || echo 0"
#   }


#   provisioner "local-exec" {
#     command = "kubectl create secret generic jenkins-docker-cfg --from-file=${path.module}/templates/config.json"
#   }


#   depends_on = ["null_resource.jx_check"]
# }

