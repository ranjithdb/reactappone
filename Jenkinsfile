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
        
        stage('Build Docker Image') {
            steps {
                script {
                    def branchName = env.GIT_BRANCH == 'origin/dev' ? 'dev' : 'prod'
                    def imageTag = branchName == 'dev' ? 'dev-latest' : 'prod-latest'
                    def imageName = branchName == 'dev' ? "${DOCKER_DEV_REPO}:${imageTag}" : "${DOCKER_PROD_REPO}:${imageTag}"
                    
                    // Build and push Docker image
                    sh "docker build -t ${imageName} ."
                    withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        sh "echo $PASSWORD | docker login -u $USERNAME --password-stdin"
                        sh "docker push ${imageName}"
                    }
                }
            }
        }

        stage('Deploy Docker Compose') {
            steps {
                script {
                    // Pull and start Docker Compose
                    sh "./deploy.sh ${env.GIT_BRANCH == 'origin/dev' ? 'dev' : 'prod'}"
                }
            }
        }
    }
}
