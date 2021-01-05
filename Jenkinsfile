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
        
        withCredentials([usernamePassword(credentialsId: 'github', usernameVariable: 'skywalker225', passwordVariable: 'xxxx')]) {
        // available as an env variable, but will be masked if you try to print it out any which way
        // note: single quotes prevent Groovy interpolation; expansion is by Bourne Shell, which is what you want
        sh 'echo $PASSWORD'
        // also available as a Groovy variable
        echo USERNAME
        // or inside double quotes for string interpolation
        echo "username is $USERNAME"
        
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
