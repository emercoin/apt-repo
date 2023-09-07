#### Emercoin APT repository
[deb.emercoin.com](https://deb.emercoin.com)

emercoin installation via apt

```
sudo dpkg -i $(curl -L https://github.com/emercoin/apt-repo/releases/download/current/emcrepo-$(dpkg --print-architecture).deb -o emcrepo-$(dpkg --print-architecture).deb && echo -e emcrepo-$(dpkg --print-architecture).deb) && rm emcrepo-*.deb && install-emercoin
```

if you encounter issues with the above step  which resulted in emercoin not being installed, at that point try
```
apt install emercoin-bin
```

If you have issues, we are happy to assist on telegram [@emercoin](https://t.me/emercoin)

[github.com/emercoin/apt-repo](https://github.com/emercoin/apt-repo)
