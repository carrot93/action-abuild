# action-abuild

GitHub Action that builds Alpine Linux packages

## Usage

See [action.yml](./action.yml) for comprehensive list of options.

```yaml
name: "Build Alpine package"
on:
  schedule:
  - cron: "0 0 * * *"

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Check out aports
      uses: actions/checkout@master
    - name: Try building the new release version
      uses: acj/action-abuild@v1
      with:
        PACKAGE_PATH: "main/curl"
        RELEASE_VERSION: "1.2.3"
```
