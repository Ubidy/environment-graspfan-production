pipeline {
  options {
    disableConcurrentBuilds()
  }
  agent {
    label "jenkins-maven"
  }
  environment {
    DEPLOY_NAMESPACE = "jx-live"
    CHART_REPOSITORY = "https://charts.helm.sh/stable"
  }
  stages {
    stage('Validate Environment') {
      steps {
        container('maven') {
          dir('env') {
            sh "curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh"
            sh "chmod 700 get_helm.sh"
            sh "./get_helm.sh"
            sh "helm init"
            sh "helm repo add jenkins-x http://chartmuseum.jx.20.188.210.222.nip.io/"
            sh "jx step helm release"
            sh 'jx step helm build'
          }
        }
      }
    }
    stage('Update Environment') {
      when {
        branch 'master'
      }
      steps {
        container('maven') {
          dir('env') {
            sh 'jx step helm apply'
          }
        }
      }
    }
  }
}
