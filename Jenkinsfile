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
                    git credentialsId: 'github-jenkins-ssh',
                        url: 'git@github.com:DEL-ORG/a1franklin.git',
                        branch: "${params.BRANCH_NAME}"
                }
            }
        }


        stage('Test') {
            steps {
                sh '''
                kubectl 
                pwd
                uname -r 
                touch eric
                '''
            }
        }

        stage('Validate') {
            steps {
                sh 'pwd'
            }
        }

        stage('Scan') {
            steps {
                sh 'pwd'
            }
        }

        stage('Build') {
            steps {
                sh '''
                echo "FROM httpd:2.4" > Dockerfile
                docker build -t eric .
                docker images
                '''
            }
        }

        stage('Push') {
            steps {
                sh 'pwd'
            }
        }

        stage('Deploy') {
            steps {
                sh 'pwd'
            }
        }
    }

    post {
        always {
            script {
                // Add your post-build actions here
            }
        }
    }
}
