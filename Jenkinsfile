pipeline{

	agent {label 'defaultnode'}

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockeraccount')
	}

	stages {
	    stage('Clone') {

			steps {
				git 'https://github.com/khoicrtp/jenkins'
			}
		}

		stage('Build') {

			steps {
				bat 'docker build -t khoicrtp/jenkins:latest .'
			}
		}

		stage('Login') {
			steps {
				//bat 'echo winpty %DOCKERHUB_CREDENTIALS_PSW% | docker login -u %DOCKERHUB_CREDENTIALS_USR%'
				bat 'echo docker login -u %DOCKERHUB_CREDENTIALS_USR% -p %DOCKERHUB_CREDENTIALS_PSW%'
			}
		}
        stage('Push') {
            steps{
                withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
                    bat "docker push khoicrtp/jenkins:latest"
                }
            }
        }
	}

	post {
		always {
			bat 'docker logout'
		}
	}
}