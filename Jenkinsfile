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

        stage('SCM') {
            steps {
                checkout scm
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

        stage("Push Docker Hub"){
            steps{
                script {
                    env.COMMIT = sh (script: 'git log -n 1 --pretty=format:"%h"', returnStdout: true)
                }
                withCredentials([usernamePassword(credentialsId: 'docker_hub', passwordVariable: 'password', usernameVariable: 'username')]) {
                    sh 'docker build -t khaledmohamedatia/node_app:${COMMIT} ./app/'
                    // sh 'docker login  -u ${username} -p ${password}'
                    // sh 'docker push khaledmohamedatia/node_app:${COMMIT}'
                }
            }
        }

        stage('Scan Docker Image') {
            steps {
                sh 'trivy image --no-progress --scanners vuln  --exit-code 1khaledmohamedatia/node_app:${COMMIT}'
            }
        }
        
        // stage("Trigger Parameters"){
        //     steps{
        //         build job: 'cd_job' , parameters : [string(name: 'COMMIt', defaultValue: env.COMMIT , description: 'trigger ')]
        //     }
        // }
        
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