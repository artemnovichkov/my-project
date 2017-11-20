## 📦 Frameworks

A test project for showing first-party framework integration. The main goal of this approach is to link a compiled static frameworks to prevent extra rebuilding.

Current structure:
- `MyWorkspace` - a workspace with all projects and playgrounds
- `MyProject` - a main app with linked static frameworks
- `MyFrameworkExample` - an example with a `MyFramework` target for isolated framework testing
- `MyFrameworkPlayground` - an playground with a `MyFramework` framework for isolated framework testing

## 🚀 Main flow

1. Add new features to `MyFramework`.
2. Test it:
 - via `MyFrameworkExample`. It let you store different enviroments.
 - via `MyFrameworkPlayground`. The same as above plus no need to run a simulators.
3. Run `MyFramework-Universal` target. It creates an universal static framework and save it to `Frameworks` folder in the main project.

## 🤔 Current issues

- Manual configuration of new projects for this scheme
- Playgrounds don't work with static frameworks. So after `MyFramework-Universal` target running you should clean the Build folder.
- You must run `MyFramework-Universal` target manually after every change in the framework.
- Workspace has one DerivedData folder for all projects. After main project cleaning all frameworks data will be deleted.
