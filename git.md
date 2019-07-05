# git

Command | Description
--- | ---
`git log -p <path>` | Show the changes to a file
`git log --grep <string>` | Filter commits by message
`git push origin --delete <branch>` | Delete remote branch
`git reset HEAD~1` | Remove last commit (_only if not pushed yet!_)
`git checkout 'git rev-list -n 1 --before="2009-07-27 13:37" master'` | Check out by date
`git remote prune origin` | Remove local branches that do not exist in origin
`git config user.name "scheleaap" && git config user.email "git@wout.maaskant.info"` | Set user & email
`git merge --strategy ours` | Merge resolving any conflicts with 'our' version


## Cherry pick all commits from a branch

From https://stackoverflow.com/questions/35437253/how-to-git-cherrypick-all-changes-introduced-in-specific-branch

BRANCH=feature-com-8138-tax_refund_booking_subtype_part2
git cherry-pick $(git merge-base master $BRANCH)..$(git log --format=%H $BRANCH | head -1)


## Whitespace merges

From https://git-scm.com/book/tr/v2/Git-Tools-Advanced-Merging 

> The default merge strategy can take arguments though, and a few of them are about properly ignoring whitespace changes. If you see that you have a lot of whitespace issues in a merge, you can simply abort it and do it again, this time with -Xignore-all-space or -Xignore-space-change. The first option ignores changes in any amount of existing whitespace, the second ignores all whitespace changes altogether.
> 
> $ git merge -Xignore-all-space whitespace


## Per ongeluk op master gecommit in plaats van op een branch

Als je nog niet gepusht hebt:

1. `git co master`
2. `git co -b feature-<...>`
3. `git co master`
4. `git reset HEAD~1` om de laatste commit weg te halen. Waarschijnlijk werkt een commit id ook.


## Restore state of a previous commit

```
git rm -r .
git checkout HEAD~3 .
git commit
```
After the commit, files in the new HEAD will be the same as they were in the revision HEAD~3.


## Delete all local and remote tags

```bash
# Delete local tags.
git tag -d $(git tag -l)
# Fetch remote tags.
git fetch
# Delete remote tags.
git push origin --delete $(git tag -l) # Pushing once should be faster than multiple times
# Delete local tags.
git tag -d $(git tag -l)
```

From https://gist.github.com/okunishinishi/9424779
