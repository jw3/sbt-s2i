s2i for sbt
===========

Created using s2i [v1.1.7](https://github.com/openshift/source-to-image/releases/tag/v1.1.7)

### invoke

`s2i build <source code path / URL> sbts2i <application image>`

You can then run the resulting image via:

`docker run <application image>`

### Configuration

`SBT_SUBPROJECT`; String: Specify the subproject that this build targets
