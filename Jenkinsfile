pipeline{

    agent any

    parameters {
        string(name: 'COMMIT', defaultValue: env.COMMIT)
    }

    environment {
        USER_NAME   =  "khaledeldsoky"
        EMAIL       =  "khlaedmohamedeldsoky@gmail.com"
    }

    stages{

        stage("Checkout Github"){
            steps{
                git branch: 'cd', url: 'https://github.com/khaledeldsoky/DevOps.git' 
            }
        }
      
        stage('Read Commit to File') {
            steps {
                script {
                    def commit_hash = readFile(file: "./var/lib/jenkins/workspace/ci_pip/commit.txt")
                    env.COMMIT = commit_hash
                    sh "echo ${env.COMMIT}"
                }
            }
        }

        stage('Push Changes to GitHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "github_token", usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                    sh """
                    echo "${params.COMMIT}"
                    sh image_tag.sh app/deployment.yml ${params.COMMIT}
                    git config --global user.name ${USER_NAME}
                    git config --global user.email ${EMAIL}
                    git add .
                    if git status --porcelain | grep -q .; then
                        git commit -m "from git commit ${params.COMMIT}"
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