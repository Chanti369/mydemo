pipeline {
    agent any
    environment{
        PATH = "/opt/maven/bin:$PATH"
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
        stage('Integartion testing'){
            steps{
                script{
                    sh 'mvn clean verify -DskipUnitTests'
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
        stage('nexus stage'){
            steps{
                script{
                    def readpom = readMavenPom file: 'pom.xml'
                    def readversion = readpom.version
                    nexusArtifactUploader artifacts: [[artifactId: 'springboot', classifier: '', file: 'target/Uber.jar', type: 'jar']], credentialsId: 'nexus', groupId: 'com.example', nexusUrl: '13.127.38.139:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'demoapp-release', version: readversion
                }
            }
        }
    }
}