CHART_REPOSITORY := http://jenkins-x-chartmuseum:8080
DIR := "env"
NAMESPACE := "jx-live"
OS := $(shell uname)

build: clean
	rm -rf requirements.lock
	helm version
	helm init --stable-repo-url https://charts.helm.sh/stable
	# helm repo add stable https://charts.helm.sh/stable
	# helm repo add jenkins-x http://chartmuseum.jenkins-x.io
	# helm repo add storage.googleapis.com https://charts.helm.sh/stable
	helm repo add releases ${CHART_REPOSITORY}
	helm dependency build ${DIR}
	helm lint ${DIR}

install: 
	helm upgrade ${NAMESPACE} ${DIR} --install --namespace ${NAMESPACE} --debug

delete:
	helm delete --purge ${NAMESPACE}  --namespace ${NAMESPACE}

clean:


