#!/bin/sh

katydidversion=current # katydid version
p8computeversion=v1.1.0 # p8compute version 
locustversion=v2.5.3
katydiddir=/usr/local/p8/katydid/${katydidversion}  # in container.
locustdir=/usr/local/p8/locust/${locustversion} # in container
p8computedir=/usr/local/p8/compute/${p8computeversion} # in container.
outputdir=/tmp/locust-tutorial/output # in container

echo '#!/bin/bash' > katydidcommands.sh
echo source ${p8computedir}/setup.sh >> katydidcommands.sh

# Enter (or uncomment) a Katydid command below, with format "Katydid -c configfile.yaml" or "Katydid -c configfile.json"

echo Katydid -c ${locustdir}/config/katydid.json --egg-file ${outputdir}/locust_mc.egg -n 4 --brw-file ${outputdir}/basic.root --rsw-file ${outputdir}/spectrogram.root >> katydidcommands.sh

# End Katydid commands.

chmod +x katydidcommands.sh

# Start the container, mount the shared directory, and execute the Katydid commands.
docker run -it --rm -v ~/p8tutorial:/tmp ghcr.io/project8/luna:latest /bin/bash -c /tmp/locust-tutorial/scripts/katydidcommands.sh

