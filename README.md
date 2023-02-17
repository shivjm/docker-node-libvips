# docker-node-libvips

![](https://img.shields.io/github/workflow/status/shivjm/docker-node-chromium-alpine/Build%20and%20publish%20to%20Docker%20Hub) ![](https://img.shields.io/docker/pulls/shivjm/node-chromium-alpine)

A Docker image including libvips (built from source) and Node.JS in Debian. Good base image for users of image processing libraries like [sharp](https://github.com/lovell/sharp).

## Repository

https://github.com/shivjm/docker-node-libvips/

## Issues

https://github.com/shivjm/docker-node-libvips/issues/

## Tags

<code>node<var>N</var>-libvips<var>V</var></code>, where <var>N</var> is the Node.js major version number (14, 16, 17, 18, or 19) and <var>V</var> is the libvips version (currently only 8.14.1). For example, to use Node.js v14 with libvips v8.14.1, use the `shivjm/node-libvips:node14-libvips8.14.1` image. No `latest` image is provided.

[See the full list of tags on Docker Hub.](https://hub.docker.com/repository/docker/shivjm/node-libvips/tags?page=1&ordering=last_updated)

## Optional libvips features enabled

* libjpeg
* libexif
* librsvg
* cgif (installed from bookworm repository)
* libtiff
* fftw3
* lcms2
* libimagequant
* orc-0.4
* libwebp
* libheif

libopenjp2 is installed but doesn’t appear to be recognized, so JPEG2000 images probably aren’t supported.

Improvements welcome.

## Example

With a Node project whose package.json includes sharp as a dependency:

```bash
# If you need to create a new Node project.
mkdir my-new-project
cd my-new-project
npm init -y

# To install sharp and save it in the project’s dependencies.
npm install -S sharp
```

Dockerfile:

```dockerfile
FROM shivjm/node-libvips:node16-libvips8.14.1

# First install the dependencies.

COPY package.json package-lock.json ./

RUN npm ci

# Then copy the code.

COPY . ./

CMD ["node", "index.js"]
```
