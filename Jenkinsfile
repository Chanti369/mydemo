pipeline{
    agent{
        node{
            label 'mynode'
        }
    }
    tools{
        maven 'MAVEN'
    }
    stages{
        stage('Git checkout'){
            steps{
                script{
                    git branch: 'main', url: 'https://github.com/Chanti369/mydemo.git'
                }
            }
        }
        stage('mvn test'){
            steps{
                script{
                    sh 'mvn test'
                }
            }
        }
    }
}