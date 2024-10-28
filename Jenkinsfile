pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds'
        DOCKER_DEV_REPO = 'ranjithdbas/reactapponedev'
        DOCKER_PROD_REPO = 'ranjithdbas/reactapponeprod'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build and Push Docker Image') {
            steps {
                script {
                    def branchName = env.GIT_BRANCH == 'origin/dev' ? 'dev' : 'prod'
                    def imageTag = branchName == 'dev' ? 'dev-latest' : 'prod-latest'
                    def imageName = branchName == 'dev' ? "${DOCKER_DEV_REPO}:${imageTag}" : "${DOCKER_PROD_REPO}:${imageTag}"

                    sh "docker build -t ${imageName} ."

                    withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh """
                            echo \$PASSWORD | docker login -u \$USERNAME --password-stdin
                            docker push ${imageName}
                        """
                    }
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                script {
                    def environment = env.GIT_BRANCH == 'origin/dev' ? 'dev' : 'prod'
                    sh "./deploy.sh ${environment}"
                }
            }
        }
    }
    
    post {
        success {
            echo "Build and deployment successful for branch ${env.GIT_BRANCH}"
        }
        failure {
            echo "Build or deployment failed for branch ${env.GIT_BRANCH}"
        }
        always {
            cleanWs()
        }
    }
}
