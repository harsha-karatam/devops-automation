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
    }
}
             stage ('SonarQube Analyses') {
        steps {
            withSonarQubeEnv('sonar6') {
              sh 'mvn sonar:sonar -Dsonar.host.url=http://10.0.1.74:9000 -Dsonar.token=sqp_cbc0770b7f57af73f65c4d168de370e562108017'
            }
            timeout(time: 2, unit: 'MINUTES') {    
                script {
                  waitForQualityGate abortPipeline: true
                }
          }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t javatechie/devops-integration .'
                }
            }
        }
        stage('Push image to Hub'){
            steps{
                script{
                   withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                   sh 'docker login -u harshakaratam -p ${Harsha11@123}'

}
                   sh 'docker push harshakaratam/devops-integration'
                }
            }
        }
        stage('Deploy to k8s'){
            steps{
                script{
                    kubernetesDeploy (configs: 'deploymentservice.yaml',kubeconfigId: 'k8sconfigpwd')
                }
            }
        }
    }
}
    
