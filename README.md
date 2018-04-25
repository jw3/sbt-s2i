s2i for sbt
===

Created using s2i [v1.1.7](https://github.com/openshift/source-to-image/releases/tag/v1.1.7)

### create

Create the s2i image with

`#! SBT_VERSION=0.13.16 SCALA_VERSION=2.12.3 make`

### invoke

Build the application image

`s2i build <path / url> sbt-s2i <image-name>`

### configuration

- `SBT_SUBPROJECT`; optional string that specifies the sbt subproject to build in (not needed if not multi-project)
- `plugins.sbt`; contains default set of sbt plugins that will be cached during the image build

### yml templates

- Full config in `template.yml`
- ImageStream in `imagestream.yml`

To see the parameters for a template from the cli

```
#! oc process --parameters -f imagestream.yml 
NAME                DESCRIPTION                             GENERATOR           VALUE
SBT_VERSION         Version of SBT to use (eg. 0.13.16).                        0.13.16
SCALA_VERSION       Version of Scala to use (eg. 2.12.5).                       2.12.5
```

To process a template from the cli

`oc create -f <template>`
