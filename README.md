#### Emercoin APT repository
[deb.emercoin.com](https://deb.emercoin.com)

emercoin installation via apt

```
sudo dpkg -i $(curl -L https://github.com/emercoin/apt-repo/releases/download/current/emcrepo-$(dpkg --print-architecture).deb -o emcrepo-$(dpkg --print-architecture).deb && echo -e emcrepo-$(dpkg --print-architecture).deb) && rm emcrepo-*.deb && sudo install-emercoin || sudo apt install emercoin-bin

```

if you encounter issues with the above step  which resulted in emercoin not being installed, at that point try
```
sudo apt install emercoin-bin
```

If you have issues, we are happy to assist on telegram [@emercoin](https://t.me/emercoin_en)

[github.com/emercoin/apt-repo](https://github.com/emercoin/apt-repo)
