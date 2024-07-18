pipeline {
    agent any
    
    options {
        buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '3', numToKeepStr: '3'))
        disableConcurrentBuilds()
        timeout(time: 7, unit: 'HOURS')
        timestamps()
    }
    
    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Enter the name of the branch')
    }
    
    triggers {
        githubPush() // Trigger the pipeline on GitHub push events
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                script {
                    git credentialsId: 'new-do-it-jenkins-github',
                        url: 'git@github.com:DEL-ORG/a1franklin.git',
                        branch: "${params.BRANCH_NAME}"
                }
            }
        }
        
        stage('Unit Test UI') {
            agent {
                docker {
                    image 'maven:3.8.3-openjdk-17'
                    args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh '''
                    cd do-it-yourself/src/ui
                    mvn test -DskipTests=true
                '''
            }
        }
        
        stage('Unit Test Catalog') {
            agent {
                docker {
                    image 'golang:1.22.5'
                    args '-u 0:0'
                }
            }
            steps {
                sh '''
                    cd do-it-yourself/src/catalog
                    go test -buildv=false
                '''
            }
        }
        
        stage('Unit Test Cart') {
            agent {
                docker {
                    image 'maven:3.8.3-openjdk-17'
                    args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh '''
                    cd do-it-yourself/src/cart
                    mvn test -DskipTests=true
                '''
            }
        }
        
        stage('Unit Test Orders') {
            agent {
                docker {
                    image 'maven:3.8.3-openjdk-17'
                    args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh '''
                    cd do-it-yourself/src/orders
                    mvn test -DskipTests=true
                '''
            }
        }
        
        stage('Unit Test Checkout') {
            agent {
                docker {
                    image 'node:20.15.1'
                    args '-u root:root'
                }
            }
            steps {
                sh '''
                    cd do-it-yourself/src/checkout
                    npm install
                '''
            }
        }

        stage('SonarQube analysis') {
            agent {
                docker {
                    image 'sonarsource/sonar-scanner-cli:10.0'
                }
            }
            environment {
                CI = 'true'
                scannerHome = '/opt/sonar-scanner'
            }
            steps {
                withSonarQubeEnv('sonarqube') {
                    withCredentials([string(credentialsId: 'a1franklin-sonarqube', variable: 'SONAR_LOGIN')]) {
                        sh """
                            ${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=a1franklin-do-it-yourself \
                            -Dsonar.projectName=do-it-yourself \
                            -Dsonar.projectVersion=1.0 \
                            -Dqualitygate.wait=true \
                            -Dsonar.sourceEncoding=UTF-8 \
                            -Dsonar.sources=./do-it-yourself \
                            -Dsonar.java.binaries=do-it-yourself/src/misc/style/java \
                            -Dsonar.login=$SONAR_LOGIN
                        """
                    }
                }
            }
        }
        
        stage('Quality Gate') {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        
        success {
            echo 'All tests passed!'
            // Notify success (e.g., Slack, Email)
        }
        
        failure {
            echo 'Tests failed!'
            // Notify failure (e.g., Slack, Email)
        }
    }
}
