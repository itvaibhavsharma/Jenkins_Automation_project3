From centos:latest
run yum install yum-utils wget -y
run wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
run rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

run yum install jenkins java-1.8.0-openjdk-devel net-tools git python3 -y --nogpgcheck

run echo "jenkins ALL=(ALL) NOPASSED:ALL" >> /etc/sudoers

run touch /etc/yum.repos.d/kubernetes.repo
run echo $'[kubernetes]\n\
name=Kubernetes\n\
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64\n\
enabled=1\n\
gpgcheck=1\n\
repo_gpgcheck=1\n\
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg' >> /etc/yum.repos.d/kubernetes.repo

run yum install -vy kubectl

copy ca.crt /root/.kube/client.crt
copy client.crt /root/.kube/client.crt
copy client.key /root/.kube/client.key

copy config /root/.kube/config

expose 8080
cmd java -jar /usr/lib/jenkins/jenkins.war



