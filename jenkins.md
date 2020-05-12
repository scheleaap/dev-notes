# Jenkins

## Job DSL

### Configuring Traits

```groovy
        // Using configure() to add a trait overrides all traits set by the build*() methods on branchSources -> github.
        // Normally, we'd use the build*() methods on branchSources -> github. But because we need to set one more trait
        // with configure() (i.e. Checkout over SSH), we need to set all of them here.
        // See also:
        // https://issues.jenkins-ci.org/browse/JENKINS-46202
        // https://issues.jenkins-ci.org/browse/JENKINS-53912
        // https://github.com/Catrobat/Jenkins/blob/master/job_dsl/src/main/lib/MultibranchPipelineJobBuilder.groovy
        configure {
            def traits = it / sources / data / 'jenkins.branch.BranchSource' / source / traits

            // Discover branches
            traits << 'org.jenkinsci.plugins.github__branch__source.BranchDiscoveryTrait' {
                // 1 = Exclude branches that are also filed as PRs
                // 2 = Only branches that are also filed as PRs
                // 3 = All branches
                strategyId(3)
            }

            // Discover pull requests from origin
            traits << 'org.jenkinsci.plugins.github__branch__source.OriginPullRequestDiscoveryTrait' {
                // 1 = Merging the pull request with the current target branch revision
                // 2 = The current pull request revision
                // 3 = Both the current pull request revision and the pull request merged with the current target branch revision
                strategyId(1)
            }

            // Discover pull requests from forks
            traits << 'org.jenkinsci.plugins.github__branch__source.ForkPullRequestDiscoveryTrait' {
                // Strategy:
                // 1 = Merging the pull request with the current target branch revision
                // 2 = The current pull request revision
                // 3 = Both the current pull request revision and the pull request merged with the current target branch revision
                strategyId(1)

                // Trust: From Users with Admin or Write permission
                trust(class: 'org.jenkinsci.plugins.github_branch_source.ForkPullRequestDiscoveryTrait$TrustPermission')
            }

            // Checkout over SSH
            traits << 'org.jenkinsci.plugins.github__branch__source.SSHCheckoutTrait' {
                credentialsId("jenkin-dp-ssh")
            }

            // Wipe out repository & force clone
            // Source: https://gitter.im/jenkinsci/jenkins?at=5d630873a498b67237964f27
            traits << 'jenkins.plugins.git.traits.WipeWorkspaceTrait' {
                extension(class: 'hudson.plugins.git.extensions.impl.WipeWorkspace')
            }
        }
    }
}
```
