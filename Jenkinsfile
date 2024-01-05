pipeline {
    agent any
    tools{
        maven 'Maven_3_9_6'
    }

    stages{
        stage('Build Maven'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/harsha-karatam/devops-automation']]])
                sh 'mvn clean install'
            }
        }
      stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t harshakaratam/numeric-0.0.1 .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                  withCredentials([string(credentialsId: 'harshakaratam', variable: 'dockerhubpwd')]) {
                  sh 'docker login -u harshakaratam -p ${dockerhubpwd}'
                  }                 
                      sh 'docker push harshakaratam/numeric-0.0.1'
                }
            }
        }
         stage('Deploy to k8s'){
            steps{
                script{
                    kubernetesDeploy configs: 'deploymentservice.yaml', kubeConfig: [path: ''], kubeconfigId: 'k8sconfigpwd', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
    }
}
}
