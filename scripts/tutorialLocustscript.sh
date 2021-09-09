#!/bin/bash

p8hexbugdir=/tmp/hexbug # in container, bound to ${tutorialdir}/hexbug locally.
locustversion=v2.2.0 # locust version
p8computeversion=v0.10.2 # p8compute version 
p8locustdir=/usr/local/p8/locust/${locustversion}  # in container.
p8computedir=/usr/local/p8/compute/${p8computeversion} # in container.
tutorialdir=~/p8tutorial # path to locust-tutorial directory on local machine.  


# Generate new command script:
echo '#!/bin/bash' > ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh
echo source ${p8computedir}/setup.sh >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh
echo source ${p8locustdir}/bin/kasperenv.sh >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Enter (or uncomment) one Locust command below, with format "LocustSim config=/path/to/config.json"

# Example 1:
echo LocustSim config=${p8locustdir}/config/LocustTestSignal.json >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Example 2:
#echo LocustSim config=${p8locustdir}/config/LocustPlaneWaveTemplate.json >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

#Example 3:
#echo LocustSim config=${p8locustdir}/config/LocustMagDipoleAntennaTemplate.json >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

#Example 4:  
#echo LocustSim config=${p8locustdir}/config/LocustFreeSpaceTemplate.json >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

#Example 5:
#echo LMCKassiopeia ${p8locustdir}/config/JustKassFieldMap.xml >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

#Example 6:
#echo LocustSim config=${p8hexbugdir}/Phase3/LocustPhase3Template.json >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# End Locust commands.

chmod +x ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Start the container, mount the shared directory(ies), and execute the Locust commands:
docker run -it --rm -v ${tutorialdir}:/tmp -v ${tutorialdir}/locust-tutorial/output:${p8locustdir}/output project8/p8compute /bin/bash -c /tmp/locust-tutorial/scripts/locustcommands.sh

