## 📦 Frameworks

A test project for showing first-party framework integration. The main goal of this approach is to link a compiled static frameworks to prevent extra rebuilding.

## Features

- ⚡️ Fast project build - no need to wait frameworks
- 🛀 Isolated testing of frameworks
- 🤖 Debug compiled frameworks via workspace

## 🚀 Main flow

Current project structure:
- `MyWorkspace` - a workspace with all projects and playgrounds
- `MyProject` - a main app with linked static frameworks
- `MyFrameworkExample` - an example with a `MyFramework` target for isolated framework testing
- `MyFrameworkPlayground` - an playground with a `MyFramework` framework for isolated framework testing

Follow below steps for project changes:

1. Add new features to `MyFramework`.
2. Test it:
 - via `MyFrameworkExample`. It lets you store different enviroments.
 - via `MyFrameworkPlayground`. The same as above plus no need to run simulators.
3. Run `MyFramework-Universal` target. It creates an universal static framework and save it to `Frameworks` folder in the main project.

## 🤔 Current issues

- Manual configuration of new projects according this scheme
- Playgrounds don't work with static frameworks:

```bash
Playground execution failed:

error: Couldn't lookup symbols:
  __T011MyFramework0A5ClassCMa
  __T011MyFramework0A5ClassC3logyyFZ
```
So after `MyFramework-Universal` target running you should clean the Build folder.

- You must run `MyFramework-Universal` target manually after every change in the framework.
- Doesn't work with New Build System for universal framework building:
```bash
error: accessing build database ".../Build/Intermediates.noindex/XCBuildData/build.db": disk I/O error
```
