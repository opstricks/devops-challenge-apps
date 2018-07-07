#!/bin/bash
set -e
set -o pipefail

BIN_DIR="$(cd "$(dirname "$0")" && pwd)/.bin"
TMP_DIR="$BIN_DIR/tmp"


#cloud_providers
install_awscli="yes"
install_google_cloud_cli="yes"

# docker tools
install_docker="latest"

# Kubernetets tools
install_kubectl="latest"
install_helm="latest"
install_kubens_keubectx="latest"
install_skaffold="latest"
install_kops="latest"
install_heptio_authenticator="latest" # for eks authentication

# automation and dev tools
install_terraform="latest"
install_jenkins_x="latest"
install_hub="yes"
gen_ssh_keys="yes"


# Essential
apt-get update
apt-get upgrade -y
apt-get -y install apt-transport-https vim unzip curl wget jq make zsh vim openjdk-8-jre apache2-utils


# create new ssh key
if [[ "$gen_ssh_keys" == "yes" ]]; then
    if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
        mkdir -p /home/vagrant/.ssh
        ssh-keygen -f /home/vagrant/.ssh/id_rsa -N ''
        chown -R vagrant:vagrant /home/vagrant/.ssh
    fi
fi

# awscli and ebcli
if [[ "$install_awscli" == "yes" ]]; then
    # pip install -U pip
    # pip3 install -U pip
    # if [[ $? == 127 ]]; then
    #     wget -q https://bootstrap.pypa.io/get-pip.py
    #     python get-pip.py --user
    #     python3 get-pip.py --userexit
    # fi
    # pip install -U awscli   --user
    # pip install -U awsebcli --user
    apt-get install awscli -y
fi

if [[ "install_heptio_authenticator" != ""  ]]; then
    heptio_authenticator_version=0.3.0
    wget https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${heptio_authenticator_version}/heptio-authenticator-aws_${heptio_authenticator_version}_linux_amd64
    chmod +x heptio-authenticator-aws_${heptio_authenticator_version}_linux_amd64
    sudo mv  -fv heptio-authenticator-aws_${heptio_authenticator_version}_linux_amd64 /usr/local/bin/heptio-authenticator-aws
fi

# # Hub
# if [[ $install_hub == "yes" ]]; then
#     add-apt-repository ppa:cpick/hub -y
#     apt-get install git-core hub -y
# fi

# docker
if [[ "$install_docker" != ""  ]]; then
    curl -fsSL https://get.docker.com | sudo sh
    sudo usermod -aG docker vagrant
fi

# kubectl
if [[ "$install_kubectl" == "latest"  ]]; then
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg -o apt-key.gpg
  apt-key add apt-key.gpg
  #sleep 21
  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
  apt-get update
  apt-get -y install kubectl
fi

# Helm
if [[ "$install_helm" == "latest" ]]; then
    curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
    chmod 700 get_helm.sh
    ./get_helm.sh
fi



# gcloud
if [[ "$install_google_cloud_cli" == "yes"  ]]; then
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
    echo "deb http://packages.cloud.google.com/apt cloud-sdk-xenial main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    apt-get update
    apt-get install google-cloud-sdk -y
fi

#terraform
if [[ "install_terraform" != ""  ]]; then
    if [[ $install_terraform == "latest"  ]]; then
        terraform_version="$(curl -sS https://api.github.com/repos/hashicorp/terraform/releases/latest | jq -r .tag_name | sed -e 's/^v//')"
    else
        terraform_version=$install_terraform
    fi
    wget "https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip" -O terraform.zip
    sudo unzip -o terraform.zip -d /usr/local/bin
    rm terraform.zip
    # terrafrom graph export
    sudo apt-get -y install graphviz
fi

#jenkins-x
if [[ "$install_jenkins_x" != ""  ]]; then
    if [[ $install_jenkins_x == "latest"  ]]; then
        jenkins_x_version="$(curl -sS https://api.github.com/repos/jenkins-x/jx/releases/latest | jq -r .tag_name)"
    else
        jenkins_x_version=$install_jenkins_x
    fi
    curl -L "https://github.com/jenkins-x/jx/releases/download/${jenkins_x_version}/jx-linux-amd64.tar.gz"  | tar xzv
    sudo mv  -fv jx /usr/local/bin
fi

# kops
if [[ "$install_kops" != ""  ]]; then
    if [[ $install_kops == "latest"  ]]; then
        kops_version="$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)"
    else
        kops-x_version=$install_kops
    fi
    wget -O kops https://github.com/kubernetes/kops/releases/download/${kops_version}/kops-linux-amd64
    chmod +x ./kops
    sudo mv  -fv ./kops /usr/local/bin/
fi


# Skafold
if [[ "$install_skaffold" != ""  ]]; then
    if [[ $install_skaffold == "latest"  ]]; then
        skaffold_version="$(curl -sS https://api.github.com/repos/GoogleContainerTools/skaffold/releases/latest | grep tag_name  | cut -d '"' -f 4)"
    else
        skaffold_version=$install_skaffold
    fi
    curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/${skaffold_version}/skaffold-linux-amd64
    chmod +x skaffold
    sudo mv  -fv skaffold /usr/local/bin
fi

# kubens and keubectx (https://github.com/ahmetb/kubectx)
if [[ "$install_kubens_keubectx" != ""  ]]; then
  rm -rf /opt/kubectx
  rm -f /usr/local/bin/kubectx
  rm -f /usr/local/bin/kubens
  sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
  sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
  sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens
fi

ls /home/vagrant/.oh-my-zsh  && rm -rf /home/vagrant/.oh-my-zsh
ls /home/vagrant/.zshrc      && rm -f /home/vagrant/.zshrc

mkdir /home/vagrant/.oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc
chown vagrant:vagrant /home/vagrant/.oh-my-zsh -R
chown vagrant:vagrant /home/vagrant/.zshrc
