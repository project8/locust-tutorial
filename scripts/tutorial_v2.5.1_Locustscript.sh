#!/bin/bash

# EDIT THIS PATH ONLY #######################
tutorialdir=~/p8tutorial # path to locust-tutorial directory on local machine.
#############################################

p8hexbugdir=/tmp/hexbug # in container, bound to ${tutorialdir}/hexbug locally.
locustversion=v2.5.4 # locust version
locusttag=latest
p8locustdir=/usr/local/p8/locust/${locustversion}  # in container
kassiopeiadir=/usr/local/p8/kassiopeia/current
commondir=/usr/local/p8/common/${commonversion} # in container.
computedir=/usr/local/p8/compute/v1.1.1 # in container


# Generate new command script:
echo '#!/bin/bash' > ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh
echo source ${computedir}/setup.sh >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh
#echo source ${kassiopeiadir}/bin/kasperenv.sh >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh
#echo source ${computedir}/setup.sh >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh


# Enter (or just uncomment) one Locust command below, with format "LocustSim config=/path/to/config.json"

# Example 0:  Test signal.
#echo LocustSim config=${p8locustdir}/config/LocustTestSignal.json >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Example 1:  Test signal plus noise.
#echo LocustSim config=${p8locustdir}/config/LocustSignalPlusNoise.json >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Example 2:  25.9 GHz cavity (CCA)
#echo LocustSim config=${p8locustdir}/config/LocustCavityCCA.json >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Example 3:  WR42 waveguide
#echo LocustSim config=${p8locustdir}/config/LocustWaveguideTemplate.json >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Example 4:  LW free space example
#echo LocustSim config=${p8locustdir}/config/LocustFreeSpaceTemplate.json >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Example 5:  Generate B field lines in Kassiopeia.
#echo LMCKassiopeia ${p8locustdir}/config/JustKassFieldMap.xml >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Example 5A: (To be run only after generating output/JustKassMyNewFieldMap.xml file):
#echo LMCKassiopeia ${p8locustdir}/output/JustKassMyNewFieldMap.xml >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Example 6:  Generate a plot of an imported waveguide complex impedance and derived FIR
#echo LocustSim -c ${p8locustdir}/config/LocustWaveguideTemplate.json \"cavity-signal.print-fir-debug\"=true >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Example 7:  Generate a plot of an analytic cavity Green's function
#echo LocustSim -c ${p8locustdir}/config/LocustCavity1GHz.json \"cavity-signal.print-fir-debug\"=true >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Example 8:  Generate a mode map
#echo LocustSim -c ${p8locustdir}/config/LocustWaveguideTemplate.json \"cavity-signal.plot-mode-maps\"=true \"cavity-signal.n-modes\"=3 >> ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# End Locust commands.




chmod +x ${tutorialdir}/locust-tutorial/scripts/locustcommands.sh

# Start the container, mount the shared directory(ies), and execute the Locust commands:
docker run -it --rm -v ${tutorialdir}:/tmp -v ${tutorialdir}/locust-tutorial/output:${p8locustdir}/output ghcr.io/project8/luna:latest /bin/bash -c /tmp/locust-tutorial/scripts/locustcommands.sh


