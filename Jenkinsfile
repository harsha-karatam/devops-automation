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
        stage ('SonarQube Analyses') {
        steps {
            withSonarQubeEnv('sonar6') {
              sh 'mvn sonar:sonar -Dsonar.host.url=http://10.0.1.74:9000 -Dsonar.token=sqa_1461c37082c8f48ea454c7af20f5e2808685f773'
            }
            timeout(time: 2, unit: 'MINUTES') {    
                script {
                  waitForQualityGate abortPipeline: true
                }
          }
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
                    kubernetesDeploy (configs: 'deploymentservice.yaml', kubeconfigId: 'k8sconfigpwd')
}
}
}
}
}
