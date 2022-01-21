pipeline{
    options {
    disableConcurrentBuilds(abortPrevious: true)
    }

	agent {label 'defaultnode'}

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockeraccount')
        imageName='khoicrtp/jenkins:latest'
        containerName='jenkinscontainertest'
	}

	stages {
	    stage('Pre'){
	        steps {
				catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                	bat 'docker rm -f %containerName%'
				}
				catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
					bat 'docker image rm %imageName%'
				}
	        }
	    }
	    stage('Clone') {
			steps {
				git 'https://github.com/khoicrtp/jenkins'
			}
		}

		stage('Build') {
			steps {
				bat 'docker build -t %imageName% .'
			}
		}

		stage('Login') {
			steps {
				bat 'echo docker login -u %DOCKERHUB_CREDENTIALS_USR% -p %DOCKERHUB_CREDENTIALS_PSW%'
			}
		}
        stage('Push') {
            steps{
                withDockerRegistry([ credentialsId: "dockeraccount", url: "" ]) {
                    bat "docker push %imageName%"
                }
            }
        }
        stage('Deploy'){
            steps{
				bat 'docker run -p 5000:5000 --name %containerName% %imageName%'
            }
        }
	}

	post {
		always {
			bat 'docker logout'
		}
	}
}