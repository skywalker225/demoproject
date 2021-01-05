pipeline {
  agent none
  stages {
    stage('Build') {
      agent { dockerfile true }
      environment {
        GIT_AUTH = credentials('mygithub')
      }
      steps {
        echo 'Building...'
        sh 'git --version'
        sh 'make --version'
        sh 'pwd'
        sh 'touch demo_file.txt'
        sh 'ls'
        echo "${GIT_AUTH_USR}"
        //withCredentials([usernamePassword(credentialsId: 'GitHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          //sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          //sh 'docker push shanem/spring-petclinic:latest'
          //echo
        //}
        
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
