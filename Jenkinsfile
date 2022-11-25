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
        stage('integration test'){
            steps{
                script{
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }
        stage('mvn install'){
            steps{
                script{
                    sh 'mvn clean install'
                }
            }
        }
        stage('nexus'){
            steps{
                script{
                    def readpom = readMavenPom file: 'pom.xml'
                    def readversion = readpom.version
                    def readrepo = readversion.endsWith("SNAPSHOT") ? "demoapp-snapshot" : "demoapp-release"
                    nexusArtifactUploader artifacts: [[artifactId: 'springboot', classifier: '', file: 'target/Uber.jar', type: 'jar']], credentialsId: 'nexus', groupId: 'com.example', nexusUrl: '3.109.48.161:8081', nexusVersion: 'nexus3', protocol: 'http', repository: readrepo, version: readversion
                }
            }
        }
        stage('docker image'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'docker', variable: 'docker')]) {
                        sh 'docker login -u 7995323158  -p ${docker}'
                        sh 'docker build -t $JOB_NAME:v1.$BUILD_ID .'
                        sh 'docker tag $JOB_NAME:v1.$BUILD_ID 7995323158/$JOB_NAME:v1.$BUILD_ID'
                        sh 'docker tag $JOB_NAME:v1.$BUILD_ID 7995323158/$JOB_NAME:latest'
                    }    
                }
            }
        }
        stage('push'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'docker', variable: 'docker')]) {
                        sh 'docker login -u 7995323158  -p ${docker}'
                        sh 'docker push 7995323158/$JOB_NAME:v1.$BUILD_ID'
                        sh 'docker push 7995323158/$JOB_NAME:latest'
                    }
                }
            }
        }
    }
}
