#vim .bashrc
#export PATH=$PATH:/usr/local/bin/  -- > save and exit
#source .bashrc

aws configure
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
LATEST_KOPS_VERSION=$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)
curl -LO "https://github.com/kubernetes/kops/releases/download/v1.30.1/kops-linux-amd64"
chmod +x kubectl kops-linux-amd64
sudo mv kubectl /usr/local/bin/kubectl
sudo mv kops-linux-amd64 /usr/local/bin/kops
kubectl version --client
kops version

aws s3api create-bucket \
--bucket devopsbatchapr600pm776789dope.k8s.local \
--region ap-south-1 \
--create-bucket-configuration LocationConstraint=ap-south-1
aws s3api get-bucket-versioning --bucket devopsbatchapr600pm776789dope.k8s.local --region ap-south-1
export KOPS_STATE_STORE=s3://devopsbatchapr600pm776789dope.k8s.local

kops create cluster --name purushottam.k8s.local --zones ap-south-1b --master-count=1 --master-size t3.medium --node-count=2 --node-size t3.micro
kops update cluster --name purushottam.k8s.local --yes --admin

