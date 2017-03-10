# vvv-provision-single #

Single site provision setup.

### Getting Started ###

Clone the repo as the site name into your `www` directory in vvv.

```bash
$ cd vagrant-local/www
$ mkdir example.dev
$ cd example.dev
$ git clone git@github.com:mrdink/vvv-provision-single.git . && rm -rf .git
```

* Add hosts to `vvv-config.yml` or `vvv-custom.yml`
* Update `vvv-hosts` and `vvv-nginx.conf`
* Run `vagrant up && vagrant provision`
