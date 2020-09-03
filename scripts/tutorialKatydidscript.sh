#!/bin/sh


katydidversion=v2.18.0 # katydid version
locustversion=v2.1.2 # locust version available in p8compute.
p8computeversion=v0.10.1 # p8compute version 
katydiddir=/usr/local/p8/katydid/${katydidversion}  # in container.
locustdir=/usr/local/p8/locust/${locustversion} # in container
p8computedir=/usr/local/p8/compute/${p8computeversion} # in container.
outputdir=/tmp/locust-tutorial/output # in container

echo '#!/bin/bash' > katydidcommands.sh
echo source ${p8computedir}/setup.sh >> katydidcommands.sh

# Enter (or uncomment) a Katydid command below, with format "Katydid -c configfile.yaml" or "Katydid -c configfile.json"

echo Katydid -c ${locustdir}/config/katydid.json -e ${outputdir}/locust_mc.egg -n 4 --brw-file ${outputdir}/basic.root --rsw-file ${outputdir}/spectrogram.root >> katydidcommands.sh

#echo Katydid -c ${katydiddir}/config/ChannelAggregatorConfig.yaml -e ${outputdir}/locust_mc.egg --ch-sum.active-radius=0.1 -n 4 --brw-file ${outputdir}/agg_basic.root --rsw-file ${outputdir}/agg_spectrogram.root >> katydidcommands.sh

# End Katydid commands.

chmod +x katydidcommands.sh


# Start the container, mount the shared directory, and execute the Katydid commands.
docker run -it --rm -v ~/p8tutorial:/tmp project8/p8compute /bin/bash -c /tmp/locust-tutorial/scripts/katydidcommands.sh

