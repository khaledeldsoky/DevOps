pipeline{

    agent any
    // tools {
    //     maven 'maven'
    // }
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

        stage("Push Docker Hub"){
            steps{
                script {
                    env.COMMIT = sh (script: 'git log -n 1 --pretty=format:"%h"', returnStdout: true)
                }
                withCredentials([usernamePassword(credentialsId: 'docker_hub', passwordVariable: 'password', usernameVariable: 'username')]) {
                    sh 'docker build -t khaledmohamedatia/node_app:${COMMIT} ./app/'
                    sh 'docker login  -u ${username} -p ${password}'
                    sh 'docker push khaledmohamedatia/node_app:${COMMIT}'
                }
            }
        }

        // stage('sonarqube'){
        //     steps{
        //         script{
        //             sh 'cd /var/jenkins_home/workspace/ci_pip'
        //             withSonarQubeEnv(installationName: 'sq' ,credentialsId: 'sonar') {
        //                 sh 'sonar-scanner'
        //             }
        //         }

        //     }
        // }
 
        // stage("Trigger Parameters"){
        //     steps{
        //         build job: 'cd_job' , parameters : [string(name: 'COMMIt', defaultValue: env.COMMIT , description: 'trigger ')]
        //     }
        // }
        
    }
}

       node {
            stage('SCM') {
                checkout scm
            }
            stage('SonarQube Analysis') {
                def scannerHome = tool 'SonarScanner';
                withSonarQubeEnv() {
                sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }