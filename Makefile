# CHART_REPOSITORY := http://jenkins-x-chartmuseum:8080
CHART_REPOSITORY := http://chartmuseum.jx.20.188.210.222.nip.io/
DIR := "env"
NAMESPACE := "jx-production"
OS := $(shell uname)

build: clean
	rm -rf requirements.lock
	helm version
	helm init
	
	# helm repo add stable https://charts.helm.sh/stable
	helm repo add jenkins-x http://chartmuseum.jx.20.188.210.222.nip.io/
	# helm repo add storage.googleapis.com https://charts.helm.sh/stable
	helm repo add releases ${CHART_REPOSITORY}
	helm repo update
	helm dependency build ${DIR}
	helm lint ${DIR}

install: 
	helm upgrade ${NAMESPACE} ${DIR} --install --namespace ${NAMESPACE} --debug

delete:
	helm delete --purge ${NAMESPACE}  --namespace ${NAMESPACE}

clean:


