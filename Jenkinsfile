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
        githubPush() // This will trigger the pipeline on GitHub push events
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
        stage('Build & Test UI, Cart, Orders (Java)') {
            parallel {
                stage('UI') {
                    steps {
                        dir('do-it-yourself/src/ui') {
                            script {
                                // Build and test UI microservice
                                sh './gradlew clean build test'
                            }
                        }
                    }
                }
                stage('Cart') {
                    steps {
                        dir('do-it-yourself/src/cart') {
                            script {
                                // Build and test Cart microservice
                                sh './gradlew clean build test'
                            }
                        }
                    }
                }
                stage('Orders') {
                    steps {
                        dir('do-it-yourself/src/orders') {
                            script {
                                // Build and test Orders microservice
                                sh './gradlew clean build test'
                            }
                        }
                    }
                }
            }
        }
        stage('Build & Test Catalog (Go)') {
            steps {
                dir('do-it-yourself/src/catalog') {
                    script {
                        // Build and test Catalog microservice
                        sh 'go test ./...'
                    }
                }
            }
        }
        stage('Build & Test Checkout (Node.js)') {
            steps {
                dir('do-it-yourself/src/checkout') {
                    script {
                        // Install dependencies
                        sh 'npm install'
                        // Run tests
                        sh 'npm test'
                    }
                }
            }
        }
    }
    post {
        always {
            // Clean up workspace
            cleanWs()
        }
        success {
            // Notify success (e.g., Slack, Email)
            echo 'All tests passed!'
        }
        failure {
            // Notify failure (e.g., Slack, Email)
            echo 'Tests failed!'
        }
    }
}
