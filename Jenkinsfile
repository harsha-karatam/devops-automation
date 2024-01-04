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

           
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t harshakaratam/devops-integration .'
                }
            }
        }
}
