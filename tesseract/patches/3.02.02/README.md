**1**

This patch was extracted from the tesseract main repo, taking the single commit,
[https://github.com/tesseract-ocr/tesseract/commit/9b2906c...](https://github.com/tesseract-ocr/tesseract/commit/9b2906c67ea90aa4adb46f314796d53cfd6c7325), that gets rid of glob.h
usage, since that isn't available on android.

The patch was created with:

```bash
git format-patch -1 --numbered-files 9b2906c67ea90aa4adb46f314796d53cfd6c7325
```
