# Contributing

Thank you for your interest in contributing to our project. Whether it's a bug report, new feature, correction, or additional
documentation, we greatly value feedback and contributions from our community.

Please read through this document before submitting any issues or pull requests to ensure we have all the necessary
information to effectively respond to your bug report or contribution.

* [Reporting Bugs and Feature Requests](#reporting-bugs-and-feature-requests)
* [Contributing via Pull Requests](#contributing-via-pull-requests)
* [Code of Conduct](#code-of-conduct)
* [Security Issue Notifications](#security-issue-notifications)
* [Understanding Project Tenets](#understanding-project-tenets)
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

## Understanding Project Tenets

Ensure that you review the [Project Tenets](https://getstarted.awsworkshop.io/05-project/02-project-tenets.html).

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


#### Testing and Validation
Starting the Hugo server will trigger the HTML generation process.  Content will be viewable at the Hugo default http://localhost:1313/.  Before you submit your pull request, please validate the following:

- Changes should render completely and fully into HTML in accordance with the styling of the existing documentation
- Relative links work and link to the referenced area
- Hyperlinks to external documentation are complete and valid

Our build toolchain uses the [html-proofer](https://github.com/gjtorikian/html-proofer) to perform the above validations in addition to manual reviews.  The `webspec.yml` at the root of this repository is an [AWS CodeBuild buildspec file](https://docs.aws.amazon.com/codebuild/latest/userguide/getting-started-create-build-spec-console.html) which can be used to validate your changes before submission.  Use this file to set up a CodeBuild project in an AWS account or use the [AWS CodeBuild agent](https://docs.aws.amazon.com/codebuild/latest/userguide/use-codebuild-agent.html) to run the build locally.  The validations use the latest version of Hugo and the Learn theme.

### Working with Links and Hugo

#### Using `relref`

To ease the process of referring to local pages and to ease maintenance as the page hierarchy changes, it's recommended that you use the Hugo built-in shortcode [`relref`](https://gohugo.io/content-management/cross-references/).

#### Anchors

When it's helpful to link to another section in the same page or on another page, you can define custom anchors in headings of the target page and refer to those anchors from your pages.

For example, to define a customer anchor on a heading:

```
## My Heading Title {#my-custom-anchor}
```

And in another page, you can refer to the anchor:

```
... [Example Link]({{< relref "my-example-page#my-custom-anchor" >}}) ...
```

Note that when using `relref`:
* As long as the page name is unique, you don't need to quality the page name.
* You don't include the `.md` file suffix.

### Defer to External Docs Where Feasible

When there's modular, to-the-point official documentation that can be linked to, we prefer that route vs duplicating lengthy instructions within these guides.  

However, when any of the following conditions apply, in the interest of providing a cohesive user experience, we don't hesitate to embed instructions inline:
  * Steps are so few and simple that it's not worth distracting the reader by forcing them to go to another document.
  * The instructions require context or specific data to be used that other more general purpose guides don't include.
  * Instructions in other docs cannot be directly accessed via a link. For example, linking to a large PDF document and asking the reader to find a section for specific instructions is a non-starter in terms of the user experience.

### Using Automation and Infrastructure as Code (IaC)

When modular Infrastructure as Code (IaC) automation resources are either already available as open source or can be easily developed and open sourced, the project's preference is to suggest that customers use these automation resources vs documenting and having customers follow what can be complicated and drawn out step-by-step instructions.

A key caveat to the introduction of IaC is that it needs to be simple enough to provide value at this early stage of adoption. i.e. Piling on complicated solutions at this early stage of adoption may be premature.

If IaC solutions exist, but are deemed to be too complicated to apply given the relatively straightforward scope of the initial AWS environment, it can still be useful to make customers aware of the solutions in case: 1) they want to introduce it at this stage or 2) they will find value in considering it in the future.

Generally reusable IaC resources should be available as open source outside of this project.  Preferably managed in official AWS managed GitHub organizations such as AWS Samples and AWS Quick Starts.

IaC resources that are specific to the examples used in the guide may be included in this project source repository.

The project's preference is to prioritize the use of generally reusable IaC resources as compared to guide-specific resources.

### Using Screenshots

When there's an absence of existing detailed documentation to which the guide can link and there's no sample automation that the customer can use, detailed steps may be necessary to include within the guide.  Under these circumstances, it can be valuable to include screenshots in support of manual configuration steps.

### Managing and Referring to Static Images

Static images are managed under the `static/images/` area of the repository.

The `images/` directory is structured based on the structure of the guide's content folders.  As a convention, you should copy any static images associated with sections to the same area of the site hierarchy as represented in the `static/images/` area of the repository.

#### Referring to Images

When Hugo generates the static form of the site, it ensures that all of the folder under `static/` are made available at the root of the site.  For example, references to `/images/...` will resolve to content that is housed under the `static/images/` directory of the source repository.  See [Hugo Static Files](https://gohugo.io/content-management/static-files/).

Consequently, one way to link to images is to use the convention Markdown reference such as the following example. In this example, the image in included inline and enables the user to click on the image to display the native image. This may be helpful when images are large and it's difficult to see details without zooming in on the image.

```
[![Initial Development Environment](/images/01-dev/dev-initial.png)](/images/01-dev/dev-initial.png)
```
Alternatively, you can use built-in Hugo shortcode [`figure`](https://gohugo.io/content-management/shortcodes/#figure) when you need more control over how the image is displayed.

#### Resizing Images

You can append `height` and `width` to the image resource:

```
[![Transit VPC Architecture](/images/02-dev-fast-follow/01-hybrid-networking/transit-vpc-architecture.png?height=600px)](/images/02-dev-fast-follow/01-hybrid-networking/transit-vpc-architecture.png)
```

#### Testing Inclusion of Images

Note that both of the styles of including static images will not enable you test the image simply by previewing the markdown document. You'll need to run Hugo locally to see how the image will be displayed.

### Working with draw.io Files

#### Location of Drawing Files

See the `drawings/` directory for the draw.io source files used for pictures and diagrams.

#### Generating PNG Images

The `.png` drawings used in this repository are created in the following manner:

1. Open the `.drawio` file of interest using either the free online version or your internal instance of draw.io.
    * Caution when using Firefox. Make sure that the AWS service and resource icons are rendered properly. If they don't render properly, try Chrome.
1. Select the tab of interest.
1. Select "Edit -> Select All"
1. Select "File -> Export As -> PNG..."
1. Select "Selection Only" and "Crop".
1. Select "Export"
1. Select "Download"

Copy the exported PNG file to the appropriate directory under `static/images/`.

#### Tab Names in drawio Files

Since the file name and tab name are used to create the file names of exported images, you can minimize work required to export images by referring to `<file base name>-<tab name>.png` as the file name of images in your web content.

## Licensing

See the [LICENSE](LICENSE) file for our project's licensing. We will ask you to confirm the licensing of your contribution.

We may ask you to sign a [Contributor License Agreement (CLA)](http://en.wikipedia.org/wiki/Contributor_License_Agreement) for larger changes.
