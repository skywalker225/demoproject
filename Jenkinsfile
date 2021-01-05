pipeline {
  agent none
  stages {
    stage('Build') {
      agent { dockerfile true }
      steps {
        echo 'Building...'
        sh 'git --version'
        sh 'make --version'
        sh 'pwd'
        sh 'touch demo_file.txt'
        sh 'ls'
        
        withCredentials([usernamePassword(credentialsId: 'github', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh 'echo $PASSWORD'
          echo USERNAME
          echo "username is $USERNAME"
        }
        
        //git config user.name 'my-ci-user'
        //git config user.email 'my-ci-user@users.noreply.github.example.com'
        //git add . && git commit -am "[Jenkins CI] Add build file"
        //sh 'make'
      }
    }
    stage('Test') {
      steps {
        echo 'Testing...'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying...'
      }
    }
  }
}
