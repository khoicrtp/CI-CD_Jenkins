def JD_IMAGE
node {
    checkout scm
    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
        JD_IMAGE="khoicrtp/jenkins"
        def customImage = docker.build("khoicrtp/jenkins")
        /* Push the container to the custom Registry */
        customImage.push()
	}
}