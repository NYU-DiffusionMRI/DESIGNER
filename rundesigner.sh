
echo $BASH_VERSION

subjs=( diffusion_subject1 diffusion_subject2 )

root=/path/to/subjects
for i in ${subjs[@]}; do
    (
    cd $root/$i

    dwi1=(`ls | grep dwi1.nii`)
    dwi2=(`ls | grep dwi2.nii`)
    pa=(`ls | grep PA.nii`)

    echo $meso
    echo $research
    echo $pa
    
    /cbi05data/data1/Hamster/DESIGNER/designer/DESIGNER.py \
    -denoise \
    -rpg -pf 6/8 -dim 2 \
    -rician \
    -eddy -rpe_pair $pa -pe_dir -j \
    -smooth 1 \
    -akc \
    -mask \
    -nocleanup \
    -DTIparams -DKIparams -WMTIparams \
    -tempdir $out/$i/processing \
    -nocleanup \
    $dwi1,$dwi2 $root/$i/designer_out
    ) #&
done
wait


