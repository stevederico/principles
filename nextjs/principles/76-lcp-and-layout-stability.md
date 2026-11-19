# Protect the largest paint and reserve space

**Rule:** Keep the largest-content element (hero, main heading) outside or above any loading boundary, give every image, video and iframe known dimensions or an aspect ratio, preload only the single known critical image, and tell the browser how wide a responsive image really renders.

**Why:** Content inside a boundary cannot paint until its swap runs, and unsized boxes push content around when media arrives. Width and height only supply the aspect ratio. Preloading several candidates competes for bandwidth (light and dark variants would download both), and without a width hint the browser picks a source as large as the viewport, up to many times more bytes.

**Do:**
```
hero image(src, width, height, priority)     # outside any boundary, the only preload
card image(src, sizes = "33vw", lazy)
remote images: dimensions required; local assets: derive from the file
```

**Don't:** Wrap the hero in a boundary, preload every image, or flow remote images of unknown size into the page.

**Break it when:** Which image is largest depends on viewport and cannot be known; or the box has a fixed aspect ratio (fill mode inside a sized parent).

**Source:** https://nextjs.org/docs/app/guides/streaming, https://nextjs.org/docs/app/getting-started/images, https://nextjs.org/docs/app/api-reference/components/image, https://nextjs.org/docs/pages/api-reference/components/image-legacy; code: packages/next/src/shared/lib/get-img-props.ts
