s2i for sbt
===

Created using s2i [v1.1.7](https://github.com/openshift/source-to-image/releases/tag/v1.1.7)

### invoke

build an image tagged as `image-name`

`s2i build <path / url> sbt-s2i <image-name>`


### configuration

`SBT_SUBPROJECT`; optional string that specifies the sbt subproject to build in (not needed if not multi-project)
