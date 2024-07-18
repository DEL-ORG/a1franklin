pipeline {
    agent any
    
    stages {
        stage('SonarQube Analysis') {
            steps {
                script {
                    // Define SonarQube environment
                    withSonarQubeEnv('a1franklin-sonarqube') {
                        // Run SonarQube scanner
                        sh '''
                            sonar-scanner \
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
            echo 'All tests passed!'
        }
        
        failure {
            echo 'Tests failed!'
        }
    }
}
