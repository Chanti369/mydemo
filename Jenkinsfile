pipeline{
    agent any
    tools{
        maven "MAVEN"
    }
    stages{
        stage('git checkout'){
            steps{
                script{
                    git branch: 'main', url: 'https://github.com/Chanti369/mydemo.git'
                }
            }
        }
        stage('mvn test'){
            tools{
                maven "MAVEN"
            }
            steps{
                script{
                     sh 'mvn test'
                }
            }
        }
        stage('mvn integartion'){
            steps{
                script{
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }
    }
}