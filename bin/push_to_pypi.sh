#!/bin/sh
echo '
cd /my/fav/distro

python setup.py clean -a ; rm -rf *.egg-info/ dist/ */direg.egg-info/ README.rst ; find . -name "*.pyc" -exec rm "{}" \;
python setup.py check --restructuredtext --metadata

python setup.py register -r https://pypi.python.org/pypi
python setup.py sdist upload -r https://pypi.python.org/pypi --sign --identity=mburr@unintuitive.org
'
