#!/bin/bash

echo "🔧 备份原始 CentOS repo..."
cp -a /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

echo "📦 写入 Georgia Tech 镜像配置..."
cat > /etc/yum.repos.d/CentOS-Base.repo <<EOF
[base]
name=CentOS-7.9.2009 - Base
baseurl=http://mirror.gtlib.gatech.edu/pub/centos/7.9.2009/os/\$basearch/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[updates]
name=CentOS-7.9.2009 - Updates
baseurl=http://mirror.gtlib.gatech.edu/pub/centos/7.9.2009/updates/\$basearch/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[extras]
name=CentOS-7.9.2009 - Extras
baseurl=http://mirror.gtlib.gatech.edu/pub/centos/7.9.2009/extras/\$basearch/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
EOF

echo "🔁 清理并重建 YUM 缓存..."
yum clean all
yum makecache fast

echo "🧩 安装 EPEL 源..."
yum install -y epel-release

echo "📦 安装 IUS 源（可选）..."
yum install -y https://repo.ius.io/ius-release-el7.rpm

echo "✅ 所有配置完成，可使用 yum 安装最新软件包！"
