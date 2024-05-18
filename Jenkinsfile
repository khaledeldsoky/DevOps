pipeline{

    agent any
    // tools {
    //     maven 'maven'
    // }
       tools {
        nodejs "node"
        }
    parameters {
        string(name: 'COMMIT', defaultValue: env.COMMIT , description: 'docker tag from git commit')
    }

    stages{

        stage(" Delete Workspace"){
            steps{
                cleanWs()
            }
        }
        

        stage("Checkout Github"){
            steps{
                git branch: 'ci', url: 'https://github.com/khaledeldsoky/DevOps_project.git' 
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script{
                    def scannerHome = tool 'sq';
                    withSonarQubeEnv() {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }

        stage("Build Docker Hub"){
            steps{
                script {
                    env.COMMIT = sh (script: 'git log -n 1 --pretty=format:"%h"', returnStdout: true)
                }
                withCredentials([usernamePassword(credentialsId: 'docker_hub', passwordVariable: 'password', usernameVariable: 'username')]) {
                    sh 'docker build -t khaledmohamedatia/node_app:${COMMIT} ./app/'
                }
            }
        }

        stage('Scan Docker Image') {
            steps {
                sh 'trivy image --no-progress --scanners vuln  --exit-code 1 khaledmohamedatia/node_app:${COMMIT}'
            }
        }

        stage("Push Docker Hub"){
            steps{
                withCredentials([usernamePassword(credentialsId: 'docker_hub', passwordVariable: 'password', usernameVariable: 'username')]) {
                    sh 'docker login  -u ${username} -p ${password}'
                    sh 'docker push khaledmohamedatia/node_app:${COMMIT}'
                }
            }
        }
        // stage("Trigger Parameters"){
        //     steps{
        //         build job: 'cd_job' , parameters : [string(name: 'COMMIt', defaultValue: env.COMMIT , description: 'trigger ')]
        //     }
        // }
    }

    post{
        failure{
            slackSend (channel:"jenkins", color:"#FF0000", message:"FAILED: job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
        success{
            slackSend (channel:"jenkins", color:"#00FF00", message:"SUCCEEDED: job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
    }
    
}

// node {
//     stage('SCM') {
//         checkout scm
//     }
//     stage('SonarQube Analysis') {
//         def scannerHome = tool 'sq';
//         withSonarQubeEnv() {
//         sh "${scannerHome}/bin/sonar-scanner"
//         }
//     }
// }