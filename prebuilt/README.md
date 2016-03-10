# Prebuilt docker images

Images in this directory take much longer (for whatever reason) to compile, so
they're pushed up as intermediate artifacts. This allows us to test minor
tweaks on Travis as well as facilitate downloads on smaller machines.

All of these images are currently published under the tag:

```
alexcrichton/port-prebuilt-<name>:<date>
```

Where `<name>` is the name of the image and `<date>` is the date it was created.
