# rEFInd Set Default

This tool ensures that a preferred kernel (e.g., PikaOS) always remains selected as the default in rEFInd by automatically updating the timestamps when kernel updates are available.

## Installation

1. Download the `.deb` package from the [Releases](https://github.com) page.
2. Install: `sudo apt install ./refind-set-default_*_all.deb`
3. Set the desired kernel: `echo "6.18.5-pikaos" | sudo tee /etc/default/refind`
4. Run manually once: `sudo /etc/kernel/postinst.d/zz-refind-set-default`

## Build from source

```bash
make
sudo make install
```

## Credits

Concept by Ikem Krueger, implemented with the help of Google Gemini.
