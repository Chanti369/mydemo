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
        stage('mvn build'){
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
                    def version = readpom.version
                    def nexusrepo = version.endsWith("SNAPSHOT") ? "demoapp-snapshot" : "demoapp-release"
                    nexusArtifactUploader artifacts: [[artifactId: 'springboot', classifier: '', file: 'target/Uber.jar', type: 'jar']], credentialsId: 'nexus', groupId: 'com.example', nexusUrl: '13.233.101.43:8081', nexusVersion: 'nexus3', protocol: 'http', repository: nexusrepo, version: version
                }
            }
        }
        stage('build image'){
            steps{
                script{
                    sh 'docker build -t $JOB_NAME:v1.$JOB_IB .'
                    sh 'docker tag $JOB_NAME:v1.$JOB_IB 7995323158/$JOB_NAME:v1.$JOB_IB'
                    sh 'docker tag $JOB_NAME:v1.$JOB_IB 7995323158/$JOB_NAME:latest'
                }
            }
        }
        stage('push image'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'docker_hub', variable: 'docker_hub_cred')]) {
                        sh 'docker login -u 7995323158 -p ${docker_hub_cred}
                        sh 'docker push 7995323158/$JOB_NAME:v1.$JOB_IB'
                        sh 'docker push 7995323158/$JOB_NAME:latest'
                    }    
                }
            }
        }
    }
}
