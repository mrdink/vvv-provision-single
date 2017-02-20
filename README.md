# vvv-provision-single #

Single site provision setup.

### Getting Started ###

Clone the repo as the site name into your `www` directory in vvv.

`git clone git@github.com:mrdink/vvv-provision-single.git example.dev && rm -rf example.dev/.git`

* Update variables in `config/site-vars.sh`
* Update `vvv-hosts` and `vvv-nginx.conf`
* Run `vagrant up && vagrant provision`
