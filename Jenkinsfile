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
                script {
                    // Define SonarQube environment
                    withSonarQubeEnv('a1franklin-sonarqube') {
                        // Run SonarQube scanner
                        sh '''
                            ${scannerHome}/bin/sonar-scanner \
                                -Dsonar.projectKey=a1franklin-do-it-yourself \
                                -Dsonar.projectName="do-it-yourself" \
                                -Dsonar.projectVersion=1.0 \
                                -Dsonar.sources=./do-it-yourself \
                                -Dsonar.java.binaries=do-it-yourself/src/misc/style/java
                        '''
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
            echo 'Pipeline completed successfully!'
        }
        
        failure {
            echo 'Pipeline failed!'
        }
    }
}
