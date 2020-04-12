# Contributing

Thank you for your interest in contributing to our project. Whether it's a bug report, new feature, correction, or additional
documentation, we greatly value feedback and contributions from our community.

Please read through this document before submitting any issues or pull requests to ensure we have all the necessary
information to effectively respond to your bug report or contribution.

* [Reporting Bugs and Feature Requests](#reporting-bugs-and-feature-requests)
* [Contributing via Pull Requests](#contributing-via-pull-requests)
* [Code of Conduct](#code-of-conduct)
* [Security Issue Notifications](#security-issue-notifications)
* [Working with Content](#working-with-content)
* [Licensing](#licensing)

## Reporting Bugs and Feature Requests

We welcome you to use the GitHub issue tracker to report bugs or suggest features.

When filing an issue, please check existing open, or recently closed, issues to make sure somebody else hasn't already
reported the issue. 

See the project [Kanban board](https://github.com/aws-samples/aws-get-started-workshop/projects/1?fullscreen=true) for the set of already filed issues and work in progress.

When filing an issue, please try to include as much information as you can. Details like these are incredibly useful:

* A reproducible test case or series of steps
* The version of our code being used
* Any modifications you've made relevant to the bug
* Anything unusual about your environment or deployment

## Contributing via Pull Requests
Contributions via pull requests are much appreciated. Before sending us a pull request, please ensure that:

1. You are working against the latest source on the *master* branch.
2. You check existing open, and recently merged, pull requests to make sure someone else hasn't addressed the problem already.
3. You open an issue to discuss any significant work - we would hate for your time to be wasted.

To send us a pull request, please:

1. Fork the repository.
2. Modify the source; please focus on the specific change you are contributing. If you also reformat all the code, it will be hard for us to focus on your change.
3. Ensure local tests pass.
4. Commit to your fork using clear commit messages.
5. Send us a pull request, answering any default questions in the pull request interface.
6. Pay attention to any automated CI failures reported in the pull request, and stay involved in the conversation.

GitHub provides additional document on [forking a repository](https://help.github.com/articles/fork-a-repo/) and
[creating a pull request](https://help.github.com/articles/creating-a-pull-request/).

## Code of Conduct
This project has adopted the [Amazon Open Source Code of Conduct](https://aws.github.io/code-of-conduct).
For more information see the [Code of Conduct FAQ](https://aws.github.io/code-of-conduct-faq) or contact
opensource-codeofconduct@amazon.com with any additional questions or comments.

## Security Issue Notifications
If you discover a potential security issue in this project we ask that you notify AWS/Amazon Security via our [vulnerability reporting page](http://aws.amazon.com/security/vulnerability-reporting/). Please do **not** create a public github issue.

## Working with Content

### Use of Hugo Static Site Generator

The [Hugo](https://gohugo.io/) static site generator is used to render the content managed in this repository.  You can install and use Hugo locally to render and review the content.

#### Install Hugo

See [Install Hugo](https://gohugo.io/getting-started/installing/).

#### Install Learn Theme

Once you have the repository cloned locally, install the "Learn" Hugo theme

```
$ cd <root of the repository>

$  git submodule init ; git submodule update
```

#### Start Hugo Locally for Testing

```
$ hugo server -D
```

Access http://localhost:1313/

### Defer to External Docs Where Feasible

When there's modular, to-the-point official documentation that can be linked to, we prefer that route vs duplicating lengthy instructions within these guides.  

However, when any of the following conditions apply, in the interest of providing a cohesive user experience, we don't hesitate to embed instructions inline:
  * Steps are so few and simple that it's not worth distracting the reader by forcing them to go to another document.
  * The instructions require context or specific data to be used that other more general purpose guides don't include.
  * Instructions in other docs cannot be directly accessed via a link. For example, linking to a large PDF document and asking the reader to find a section for specific instructions is a non-starter in terms of the user experience.

### Working with draw.io Files

See the `drawings/` directory for the draw.io source files used for pictures and diagrams. 

The `.png` drawings used in this repository are created in the following manner:

1. Open the `.drawio` file of interest using either the free online version or your internal instance of draw.io.
1. Select the tab of interst.
1. Select "Edit -> Select All"
1. Select "File -> Export As -> PNG..."
1. Select "Selection Only" and "Crop".
1. Select "Export"
1. Select "Download"

Copy the exported PNG file to the approprite directory under `static/images/` and rename it to suit your needs.

#### Tab Names in drawio Files

Since the file name and tab name are used to create the file names of exported images, you can minimize work required to export images by ensuring that the tab names represent what you'd like to use for the image names.  When renaming, you'll just need to remove the file name that is included by default in the export image file name.

### Linking to Images

Since the project uses the [Hugo](https://gohugo.io/) static web site generation tool, see the Hugo documentation for examples of how to include images in content pages.

## Licensing

See the [LICENSE](LICENSE) file for our project's licensing. We will ask you to confirm the licensing of your contribution.

We may ask you to sign a [Contributor License Agreement (CLA)](http://en.wikipedia.org/wiki/Contributor_License_Agreement) for larger changes.
