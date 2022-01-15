node {
    checkout scm
    docker.withRegistry('https://registry.hub.docker.com/repository/docker/khoicrtp/mmtnc', 'dockerhub') {
        def customImage = docker.build("test5")
        //def customImage = docker.build("cicdjenkins")
        /* Push the container to the custom Registry */
        customImage.push()
	}
}