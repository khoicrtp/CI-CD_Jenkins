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
                withDockerRegistry([ credentialsId: "dockeraccount", url: "" ]) {
                    bat "docker push khoicrtp/jenkins:latest"
                }
            }
        }
        stage('Deploy'){
            steps{
				bat 'docker run -p 5000:5000 --name %containerName% khoicrtp/jenkins:latest'
            }
        }
	}

	post {
		always {
			bat 'docker logout'
		}
	}
}