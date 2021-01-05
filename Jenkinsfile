pipeline {
  agent none
  stages {
    stage('Build') {
      agent { dockerfile true }
      steps {
        echo 'Building...'
        sh 'pwd'
        sh 'ls'
        sh 'make --version'
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
