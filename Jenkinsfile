pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '7'))
        disableConcurrentBuilds()
        timeout(time: 10, unit: 'MINUTES')
        timestamps()
    }

    triggers {
        githubPush()
    }

    parameters {
        string(name: 'BRANCH_NAME', defaultValue: 'main', description: 'Branch to build')
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

        stage('SonarQube Analysis') {
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
                withSonarQubeEnv('sonarque') {
                    sh """
                    ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=a1franklin-do-it-yourself \
                        -Dsonar.projectName=a1franklin-do-it-yourself \
                        -Dsonar.projectVersion=1.0 \
                        -Dqualitygate.wait=true \
                        -Dsonar.sources=./do-it-yourself \
                        -Dsonar.java.binaries=do-it-yourself/src/misc/style/java
                    """
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

        stage('Scan Golang Code') {
            agent {
                docker {
                    image 'golang:1.22.5'
                    args '-u root'
                }
            }
            steps {
                sh '''
                cd do-it-yourself/src/catalog/
                ls -la  
                pwd                                                                                         
                uname -r
                go test
                '''
            }
        }

        stage('Unit Test UI Code') {
            agent {
                docker {
                    image 'maven:3.9.8'
                    args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            environment {
                DOCKER_HOST = 'unix:///var/run/docker.sock'
            }
            steps {
                sh '''
                cd do-it-yourself/src/ui
                mvn test
                '''
            }
        }

        stage('Unit Test Cart Code') {
            agent {
                docker {
                    image 'maven:3.9.8'
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

        stage('Unit Test Orders Code') {
            agent {
                docker {
                    image 'maven:3.9.8'
                    args '-u root'
                }
            }
            steps {
                sh '''
                cd do-it-yourself/src/orders
                mvn test -DskipTests=true
                '''
            }
        }

        stage('Scan Checkout Code') {
            agent {
                docker {
                    image 'node:20.15.1'
                    args '-u root'
                }
            }
            steps {
                sh '''
                cd do-it-yourself/src/checkout
                ls -la
                node --version
                npm --version
                # Add other scanning or commands as needed
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
