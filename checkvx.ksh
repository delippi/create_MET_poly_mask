#!/bin/ksh

dir="/gpfs/gd3/stmp/Donald.E.Lippi/tmpnwprd/rw_c005/namrr_metradar_f14.tm00_04/gridstat_refc_14"
inputfile="grid_stat_namrr_parent_F14_01h_REFC_140000L_20151030_180000V_pairs.nc"
inputfile=${dir}/${inputfile}
mkdir -p ./vx_masked_region_figs/psfiles


doms="SC SC4 CONUS LMV GMC SPL"

for dom in $doms
do
   plot="FCST_REFC_L0_$dom"
   plot_data_plane $inputfile       ${plot}.ps  'name="'$plot'"; level="L0";'    
   convert -rotate "90" ${plot}.ps  ${plot}.png    
   mv ${plot}.ps  ./vx_masked_region_figs/psfiles/.
   mv ${plot}.png ./vx_masked_region_figs/.
done
