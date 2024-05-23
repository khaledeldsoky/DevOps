pipeline{

    agent any

    parameters {
        string(name: 'COMMIt', defaultValue: env.COMMIt)
    }

    environment {
        USER_NAME   =  "khaledeldsoky"
        EMAIL       =  "khlaedmohamedeldsoky@gmail.com"
    }

    stages{

        stage("Checkout Github"){
            steps{
                git branch: 'cd', url: 'https://github.com/khaledeldsoky/DevOps_project.git' 
            }
        }
      
        stage('Read Commit to File') {
            steps {
                script {
                    def commit_hash = readFile(file: "../ci_pip/commit.txt")
                    env.COMMIt = commit_hash
                }
            }
        }

        stage('Push Changes to GitHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "github_token", usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                    sh """
                    sh image_tag.sh app/deployment.yml ${params.COMMIt}
                    git config --global user.name ${USER_NAME}
                    git config --global user.email ${EMAIL}
                    git add .
                    if git status --porcelain | grep -q .; then
                        git commit -m "from git commit ${params.COMMIt}"
                        git push https://${PASSWORD}@github.com/khaledeldsoky/DevOps.git HEAD:cd
                    else
                        echo "No changes to commit."

                    fi
                    """
                }
            }
        }


    }


    post{
        failure{
            slackSend (channel:"#1", color:"#FF0000", message:"FAILED: job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
        success{
            slackSend (channel:"#1", color:"#00FF00", message:"SUCCEEDED: job '${JOB_NAME} [${BUILD_ID}]' (${BUILD_URL})")
        }
    }
}