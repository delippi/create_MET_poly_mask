inputfile=g227.grib2
tag=G227

# SC NCEPY domain
gen_vx_mask $inputfile $inputfile lat_band.nc -type "lat" -thresh 'ge25&&le38'
gen_vx_mask lat_band.nc lat_band.nc ${tag}_SC.nc -type "lon" -thresh 'ge-109&&le-83' -intersection -name 'SC'

# SC4 Based off of SC (just zoomed in)
gen_vx_mask $inputfile $inputfile lat_band.nc -type "lat" -thresh 'ge28&&le35'
gen_vx_mask lat_band.nc lat_band.nc ${tag}_SC4.nc -type "lon" -thresh 'ge-104&&le-92' -intersection -name 'SC4'


# Generate plot from a polygon(*.nc) file
plot_data_plane ${tag}_SC.nc  ${tag}_SC.ps  'name="SC"; level="(*,*)";'    
plot_data_plane ${tag}_SC4.nc ${tag}_SC4.ps 'name="SC4"; level="(*,*)";'

convert -rotate "90" ${tag}_SC.ps  ${tag}_SC.png    
convert -rotate "90" ${tag}_SC4.ps ${tag}_SC4.png    





# Make standard vx regions [CONUS, GMC, LMV, SPL, etc.]
poly=/usrx/local/dev/MET/6.0/share/met/poly
doms="CONUS GMC LMV SPL"
for dom in $doms
do
gen_vx_mask -type poly $inputfile ${poly}/${dom}.poly ${tag}_${dom}.nc
plot_data_plane ${tag}_${dom}.nc ${tag}_${dom}.ps 'name="'${dom}'"; level="(*,*)";'
convert -rotate "90" ${tag}_${dom}.ps ${tag}_${dom}.png    
done






rm -f *.ps lat_band.nc

