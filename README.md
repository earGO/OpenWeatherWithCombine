### What is this?
this is an implementation of this tutorial
https://www.raywenderlich.com/4161005-mvvm-with-combine-tutorial-for-ios#toc-anchor-006

It's part of "complete 10 tutorials on MVVM in Swift" that I've challenged myself with.

### Differences
Instead of simply using the "starter" project, I've created a SwiftUI empty project in xCode and wrote everything there. Since my goal is to get better with SwiftUI, the starter projects that use UIKit apps don't fit.

Plus in general it's better to create project structure from scratch, than to work on someone else's.

I am using a lot of copied and pasted code for visuals. My goal is to understand the data flows better, so things like that are ok.

### Key challenges
When you create project in SwiftUI, the dependency injection, proposed in the starter project, doesn't work. I had to find a way to write my own DI container and inject dependencies using it.

I haven't figured out the previews, using the DI container (and tutorial project didn't have them), so I'll come back to this project again in a while to go all over it again, and specifically - to figure out the previews

Also xCode doesn't have terminal and doesn't allow to create .gitignore and readmes, so I was using zsh and Atom to do git and create files other than of project files. AppCode lacks the tooling of xCode, so I find it more convenient to use 3 tools instead of one IDE. Life is strange. 

### What I would've done differently
Initially I've decided to keep the view models separated from views. Later I've figured it would be better to structure the project "by screens", not by types of files. Most likely restructure it during 2nd pass (the branch will be named "2nd-pass"s)
