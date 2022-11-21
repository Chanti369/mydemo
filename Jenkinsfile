pipeline{
    agent any
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
    }
}