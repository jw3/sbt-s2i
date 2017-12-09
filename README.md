s2i for sbt
===

Created using s2i [v1.1.7](https://github.com/openshift/source-to-image/releases/tag/v1.1.7)

### create

Create the s2i image with

`#! SBT_VERSION=0.13.16 SCALA_VERSION=2.12.3 make`

### invoke

build an image tagged as `image-name`

`s2i build <path / url> sbt-s2i <image-name>`


### configuration

- `SBT_SUBPROJECT`; optional string that specifies the sbt subproject to build in (not needed if not multi-project)
- `plugins.sbt`; contains default set of sbt plugins that will be cached during the image build

### OpenShift Imagestream

An OpenShift Imagestream is provided that can be used in the OpenSHift console to build applications using this s2i image. To use it, simply add it as follows:

```
oc create -f sbt.yml
```

Note the openshift user must have rights to the openshift namespace (i.e. a cluster admin).
