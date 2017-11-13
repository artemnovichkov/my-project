## My Project

A test project for showing of first-party framework integration. The main goal of this approach is to link a compiled static frameworks to prevent extra rebuilding.

Current structure:
- `MyWorkspace` - a workspace with all projects and playgrounds
- `MyProject` - a main app with linked static framework.
- `MyFrameworkExample` - an example with a `MyFramework` target for isolated framework testing
- `MyFrameworkPlayground` - a playground for framework testing