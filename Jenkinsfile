pipeline {
  agent none
  stages {
    stage('Build') {
      agent { dockerfile true }
      steps {
        echo 'Building...'
        sh 'pwd'
        //writeFile file: "output/usefulfile.txt", text: "This file is useful, need to archive it."
        sh 'ls'
        sh 'git --version'
        sh 'make --version'
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
