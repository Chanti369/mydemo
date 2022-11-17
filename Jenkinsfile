pipeline {
    agent any
    environment{
        PATH = /opt/maven:$PATH
    }
    stages{
        stage('git checkout'){
            steps{
                script{
                  git branch: 'main', url: 'https://github.com/Chanti369/mydemo.git'  
                }
            }
        }
        stage('unit testing'){
            steps{
                script{
                    sh 'mvn test'
                }
            }
        }
    }
}