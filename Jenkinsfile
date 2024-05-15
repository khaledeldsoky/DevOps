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

        stage('sonarqube'){
            steps{
                withSonarQubeEnv(installationName: 'sq' ,credentialsId: 'sonar') {
                     sh 'mvn clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar'
                }
            }
        }
        // stage("Trigger Parameters"){
        //     steps{
        //         build job: 'cd_job' , parameters : [string(name: 'COMMIt', defaultValue: env.COMMIT , description: 'trigger ')]
        //     }
        // }
        
    }
}