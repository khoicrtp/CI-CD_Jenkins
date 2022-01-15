node {
    checkout scm
    docker.withRegistry('https://hub.docker.com/repository/docker/khoicrtp/mmtnc_2021', 'dockerhub') {
        def customImage - docker.build("khoicrtp/CI-CD/Jenkins")
        /* Push the container to the custom Registry */
        customImage.push()
	}
}