#!/bin/bash

# typically /etc/puppetlabs/code/environments
ENVPATH=$(puppet config print environmentpath)
# defaults to production
ENVIRONMENT=$(puppet config print environment)
# usually /etc/puppetlabs/code/environments/production
ENVDIR="${ENVPATH}/${ENVIRONMENT}"
# usually /etc/puppetlabs/code/environments/production/modules
MODULEDIR="${ENVDIR}/modules"

# create associative array (bash 4+) to hold modules and versions
declare -A modules
modules=(['puppetlabs-stdlib']='8.1.0' ['puppetlabs-vcsrepo']='5.0.0')

for mod in "${!modules[@]}"; do
  echo "installing ${mod} - ${modules[${mod}]}"
  puppet module install --ignore-dependencies --version "${modules[${mod}]}" "${mod}"
done
