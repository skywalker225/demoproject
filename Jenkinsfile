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
        //withCredentials([usernamePassword(credentialsId: 'GitHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
          //sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
          //sh 'docker push shanem/spring-petclinic:latest'
          //echo
        //}
        
        sh('''
          git checkout -B master
          git config user.name 'skywalker225'
          git config user.email 'skywalker807@gmail.com'
          git add . && git commit -am "[Jenkins CI] Add text file"
          git config --local credential.helper "!f() { echo username=\\$GIT_AUTH_USR; echo password=\\$GIT_AUTH_PSW; }; f"
          git push origin master
        ''')
        
        //git push origin HEAD:$TARGET_BRANCH
        
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
