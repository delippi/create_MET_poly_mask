#!/bin/ksh -l


pull_refd=.false.
pull_apcp=.false.
pull_prep=.true.

typeset -Z2 valcyc
typeset -Z2 valcycp5
typeset -Z2 valmon

valtime=2017080712
valpdy=`echo ${valtime} | cut -c 1-8`
valcyc=`echo ${valtime} | cut -c 9-10`
valyr=`echo ${valtime} | cut -c 1-4`
valmon=`echo ${valtime} | cut -c 5-6`
(( valcycp5 = $valcyc + 5 ))

#-- REFC
if [[ ! -s refd3d.t${valcyc}z.grb2f00 && pull_refd==".true." ]]; then
   htar -xvf /NCEPPROD/hpssprod/runhistory/rh${valyr}/${valyr}${valmon}/${valpdy}/com_hourly_prod_radar.${valpdy}.save.tar ./refd3d.t${valcyc}z.grb2f00
fi

#-- CCPA
if [[ ! -s ccpa.${valtime}.24h && pull_apcp==".true." ]]; then
   htar -xvf /NCEPPROD/hpssprod/runhistory/rh${valyr}/${valyr}${valmon}/${valpdy}/com_verf_prod_precip.${valpdy}.precip.tar ./ccpa.${valtime}.24h
fi

#-- PREPBUFR
if [[ ! -s rap.t${valcyc}z.prepbufr.tm00 && pull_prep==".true." ]]; then
   htar -xvf /NCEPPROD/hpssprod/runhistory/rh${valyr}/${valyr}${valmon}/${valpdy}/com2_rap_prod_rap.${valtime}-${valcycp5}.bufr.tar ./rap.t${valcyc}z.prepbufr.tm00
fi
