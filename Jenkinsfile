def credential = 'menther'
def userdock = 'menther'
def server = 'menther@20.0.82.144'
def directory = 'housy-backend'
def url = 'https://github.com/frenkyst/housy-backend.git'
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
      stage('Building Database First Time'){
	  steps{
	      sshagent ([credential]){
                  sh """ssh -o StrictHostkeyChecking=no ${server} << EOF
		  docker compose db.yaml up -d
                  exit
                  EOF"""
	      }
	  }
      } 
      stage('Building Docker Images'){
          steps{
              sshagent ([credential]) {
                  sh """ssh -o StrictHostkeyChecking=no ${server} << EOF
		  cd ${directory}
		  docker compose down
                  docker rmi ${userdock}/${image}
                  docker rmi ${image}
                  docker compose up -d
                  exit
                  EOF"""
              }
          }
      }
      stage('Push to Docker Hub') {
          steps {
              sshagent([credential]) {
		  sh """ssh -o StrictHostkeyChecking=no ${server} << EOF
		  docker tag ${userdock}-${image}:latest ${userdock}/${image}:latest
		  docker image push ${userdock}/${image}:latest
		  exit
		  EOF"""
	      }
	  }
      }
  }
}
