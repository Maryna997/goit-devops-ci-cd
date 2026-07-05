pipelineJob("goit-django-docker") {
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url("https://github.com/Maryna997/goit-devops-ci-cd.git")
            credentials("github-token")
          }
          branches("*/lesson-db-module")
        }
      }
      scriptPath("lesson-db-module/Jenkinsfile")
    }
  }
}
