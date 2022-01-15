node {
    checkout scm
    docker.withRegistry('https://registry.hub.docker.com/repository/docker/khoicrtp/mmtnc_2021', 'dockerhub') {
        def customImage = docker.build("khoicrtp/jenkins")
        /* Push the container to the custom Registry */
        customImage.push()
	}
}