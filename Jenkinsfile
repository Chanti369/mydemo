pipeline {
    agent any
    environment{
        PATH = "/opt/maven/bin:$PATH"
    }
    stages{
        stage('Git checkout'){
            steps{
                script{
                    git branch: 'main', url: 'https://github.com/Chanti369/mydemo.git'
                }
            }
        }
        stage('Unit Testing'){
            steps{
                script{
                    sh 'mvn test'
                }
            }
        }
        stage('Integartion Test'){
            steps{
                script{
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }
        stage('mvn build'){
            steps{
                script{
                    sh 'mvn clean install'
                }
            }
        }
    }
}