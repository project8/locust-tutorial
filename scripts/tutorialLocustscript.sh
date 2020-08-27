#!/bin/bash

p8hexbugdir=/tmp/hexbug # in container, bound to ~/p8tutorial/hexbug locally.
locustversion=v2.1.1 # locust version
p8locustdir=/usr/local/p8/locust/${locustversion}  # in container.
scriptsdir=~/p8tutorial/locust-tutorial/scripts # local scripts directory

# Generate new command script:
echo '#!/bin/bash' > ${scriptsdir}/locustcommands.sh
echo source ${p8locustdir}/setup.sh >> ${scriptsdir}/locustcommands.sh
echo source ${p8locustdir}/bin/kasperenv.sh >> ${scriptsdir}/locustcommands.sh

# Enter (or uncomment) one Locust command below, with format "LocustSim config=/path/to/config.json"

# Example 1:
echo LocustSim config=${p8locustdir}/config/LocustTestSignal.json >> ${scriptsdir}/locustcommands.sh

# Example 2:
#echo LocustSim config=${p8locustdir}/config/LocustPlaneWaveTemplate.json >> ${scriptsdir}/locustcommands.sh

#Example 3:
#echo LocustSim config=${p8locustdir}/config/LocustMagDipoleAntennaTemplate.json >> ${scriptsdir}/locustcommands.sh

#Example 4:  
#echo LocustSim config=${p8locustdir}/config/LocustFreeSpaceTemplate.json >> ${scriptsdir}/locustcommands.sh

#Example 5:
#echo LMCKassiopeia ${p8locustdir}/config/JustKassFieldMap.xml >> ${scriptsdir}/locustcommands.sh

#Example 6:
#echo LocustSim config=${p8hexbugdir}/Phase3/LocustPhase3Template.json >> ${scriptsdir}/locustcommands.sh

# End Locust commands.

chmod +x ${scriptsdir}/locustcommands.sh

# Start the container, mount the shared directory(ies), and execute the Locust commands:
docker run -it --rm -v ~/p8tutorial:/tmp -v ~/p8tutorial/locust-tutorial/output:${p8locustdir}/output project8/locust_mc /bin/bash -c /tmp/locust-tutorial/scripts/locustcommands.sh

