pipeline{

    agent any


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
                checkout  scm: scmGit( branches: [[name: '*/ci']], userRemoteConfigs: [[ url: "https://github.com/khaledeldsoky/DevOps.git" ] ] )
            }
        }

        stage("Push Docker Hub"){
            steps{
                script {
                    env.COMMIT = sh (script: 'git log -n 1 --pretty=format:"%h"', returnStdout: true)
                }
                withCredentials([usernamePassword(credentialsId: 'docker-hub-Credentials', passwordVariable: 'password', usernameVariable: 'username')]) {
                    sh 'docker build -t khaledmohamedatia/node_app:${COMMIT} ./app/'
                    sh 'docker login -p ${password} -u ${username}'
                    sh 'docker push khaledmohamedatia/node_app:${COMMIT}'
                }
            }
        }

        stage("Trigger Parameters"){
            steps{
                build job: 'cd_job' , parameters : [string(name: 'COMMIt', defaultValue: env.COMMIT , description: 'trigger ')]
            }
        }
    }
}