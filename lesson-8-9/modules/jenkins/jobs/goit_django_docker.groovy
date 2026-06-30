pipelineJob("goit-django-docker") {
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url("https://github.com/Maryna997/goit-devops-ci-cd.git")
            credentials("github-token")
          }
          branches("*/lesson-8-9")
        }
      }
      scriptPath("lesson-8-9/Jenkinsfile")
    }
  }
}
