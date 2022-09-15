def credential = 'beckend'
def userdock = 'menther'
def server = 'menther@20.0.82.144'
def directory = 'housy-backend'
def url = 'https://github.com/menther/housy-backend.git'
def branch = 'main'
def image = 'housy-backend'

pipeline{
  agent any
  stages{
     stage('Pull From Backend Repo') {
         steps {
            sshagent([credential]) {
                sh """ssh -o StrictHostkeyChecking=no ${server} << EOF
                cd ${directory}
                git remote add origin ${url} || git remote set-url origin ${url}
                git pull ${url} ${branch}
                exit
                EOF"""
              }
          }
      }
      stage('building database'){
	  steps{
	      sshagent ([credential]){
                  sh """ssh -o StrictHostkeyChecking=no ${server} << EOF
		  docker compose up -d
                  exit
                  EOF"""
	      }
	  }
      } 
      stage('building docker images'){
          steps{
              sshagent ([credential]) {
                  sh """ssh -o StrictHostkeyChecking=no ${server} << EOF
                  docker compose -f be.yaml up -d
                  exit
                  EOF"""
              }
          }
      }
      stage('Push to Docker Hub') {
          steps {
              sshagent([credential]) {
		  sh """ssh -o StrictHostkeyChecking=no ${server} << EOF
		  docker tag ${image} ${userdock}/${image}:v1
		  docker image push ${userdock}/${image}:v1
		  exit
		  EOF"""
	      }
	  }
      }
  }
}
