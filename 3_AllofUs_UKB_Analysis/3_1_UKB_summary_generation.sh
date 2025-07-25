##################### UKB SAIGE - Step1 ############################
while read p 
do
for i in {1..22}
do
nohup dx run swiss-army-knife \
-iin="UKB_Main:/Bulk/Exome sequences/Population level exome OQFE variants, PLINK format - final release/ukb23158_c${i}_b0_v1.bed" \
-iin="UKB_Main:/Bulk/Exome sequences/Population level exome OQFE variants, PLINK format - final release/ukb23158_c${i}_b0_v1.bim" \
-iin="UKB_Main:/Bulk/Exome sequences/Population level exome OQFE variants, PLINK format - final release/ukb23158_c${i}_b0_v1.fam" \
-iin="UKB_Main:/WES_470k/sparseGRM/UKB_sparseGRM_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx" \
-iin="UKB_Main:/WES_470k/sparseGRM/UKB_sparseGRM_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt" \
-iin="UKB_Main:/WES_470k/SAIGE_results/step1/${p}.rda" \
-iin="UKB_Main:/WES_470k/SAIGE_results/step1/${p}.varianceRatio.txt" \
-iin="UKB_Main:/Meta-SAIGE/groupfile/UKBexomeOQFE_chr${i}.gene.anno.hg38_PlinkMatch_v2.txt" \
-icmd="step2_SPAtests.R \
--bedFile=ukb23158_c${i}_b0_v1.bed \
--bimFile=ukb23158_c${i}_b0_v1.bim \
--famFile=ukb23158_c${i}_b0_v1.fam \
--sparseGRMFile=UKB_sparseGRM_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx \
--sparseGRMSampleIDFile=UKB_sparseGRM_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt \
--AlleleOrder=alt-first \
--SAIGEOutputFile=WES470k_Whites_${p}_chr${i}_gene \
--chrom=$i \
--minMAF=0 \
--minMAC=0.5 \
--is_overwrite_output=TRUE \
--GMMATmodelFile=${p}.rda \
--varianceRatioFile=${p}.varianceRatio.txt \
--groupFile=UKBexomeOQFE_chr${i}.gene.anno.hg38_PlinkMatch_v2.txt \
--annotation_in_groupTest=lof,missense:lof,missense:lof:synonymous \
--maxMAF_in_groupTest=0.0001,0.001,0.01 \
--is_Firth_beta=TRUE \
--pCutoffforFirth=0.05 \
--is_output_moreDetails=TRUE \
--max_MAC_for_ER=10 \
--LOCO=FALSE" \
--destination UKB_Main:/WES_470k/SAIGE_results/step2 \
--name step2_binary_${p}_chr${i} \
-iimage="wzhou88/saige:1.3.0" \
--instance-type=mem3_ssd2_v2_x8 \
-y > ~/logs/saige_step2_wgs_$p.out &
done
done < phecodes.txt

##################### UKB SAIGE - Step2 ############################

while read p 
do
for i in {1..22}
do
nohup dx run swiss-army-knife \
-iin="UKB_Main:/Bulk/Exome sequences/Population level exome OQFE variants, PLINK format - final release/ukb23158_c${i}_b0_v1.bed" \
-iin="UKB_Main:/Bulk/Exome sequences/Population level exome OQFE variants, PLINK format - final release/ukb23158_c${i}_b0_v1.bim" \
-iin="UKB_Main:/Bulk/Exome sequences/Population level exome OQFE variants, PLINK format - final release/ukb23158_c${i}_b0_v1.fam" \
-iin="UKB_Main:/WES_470k/sparseGRM/UKB_sparseGRM_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx" \
-iin="UKB_Main:/WES_470k/sparseGRM/UKB_sparseGRM_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt" \
-iin="UKB_Main:/WES_470k/SAIGE_results/step1/${p}.rda" \
-iin="UKB_Main:/WES_470k/SAIGE_results/step1/${p}.varianceRatio.txt" \
-iin="UKB_Main:/Meta-SAIGE/groupfile/UKBexomeOQFE_chr${i}.gene.anno.hg38_PlinkMatch_v2.txt" \
-icmd="step2_SPAtests.R \
--bedFile=ukb23158_c${i}_b0_v1.bed \
--bimFile=ukb23158_c${i}_b0_v1.bim \
--famFile=ukb23158_c${i}_b0_v1.fam \
--sparseGRMFile=UKB_sparseGRM_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx \
--sparseGRMSampleIDFile=UKB_sparseGRM_relatednessCutoff_0.05_5000_randomMarkersUsed.sparseGRM.mtx.sampleIDs.txt \
--AlleleOrder=alt-first \
--SAIGEOutputFile=WES470k_Whites_${p}_chr${i}_gene \
--chrom=$i \
--minMAF=0 \
--minMAC=0.5 \
--is_overwrite_output=TRUE \
--GMMATmodelFile=${p}.rda \
--varianceRatioFile=${p}.varianceRatio.txt \
--groupFile=UKBexomeOQFE_chr${i}.gene.anno.hg38_PlinkMatch_v2.txt \
--annotation_in_groupTest=lof,missense:lof,missense:lof:synonymous \
--maxMAF_in_groupTest=0.0001,0.001,0.01 \
--is_Firth_beta=TRUE \
--pCutoffforFirth=0.05 \
--is_output_moreDetails=TRUE \
--max_MAC_for_ER=10 \
--LOCO=FALSE" \
--destination UKB_Main:/WES_470k/SAIGE_results/step2 \
--name step2_binary_${p}_chr${i} \
-iimage="wzhou88/saige:1.3.0" \
--instance-type=mem3_ssd2_v2_x8 \
-y > ~/logs/saige_step2_wgs_$p.out &
done
done < phecodes.txt


##################### UKB SAIGE - Step3 LD Matrix Generation ############################

for i in {1..22}
do
dx run swiss-army-knife \
-iin="UKB_Main:/Bulk/Exome sequences/Population level exome OQFE variants, PLINK format - final release/ukb23158_c${i}_b0_v1.bed" \
-iin="UKB_Main:/Bulk/Exome sequences/Population level exome OQFE variants, PLINK format - final release/ukb23158_c${i}_b0_v1.bim" \
-iin="UKB_Main:/Bulk/Exome sequences/Population level exome OQFE variants, PLINK format - final release/ukb23158_c${i}_b0_v1.fam" \
-iin="UKB_Main:/WES_470k/group_files/UKB_AofU_loftee_groupfiles/Exome_chr_${i}_groupfile.txt" \
-iin="project-G53FX9QJ23G3bb2F4gJ09B6x:/Meta-SAIGE/WES470k/step3_idlist.csv" \
-icmd="sed -i "s/chr//g" Exome_chr_${i}_groupfile.txt ; step3_LDmat.R \
--bedFile=ukb23158_c${i}_b0_v1.bed \
--bimFile=ukb23158_c${i}_b0_v1.bim \
--famFile=ukb23158_c${i}_b0_v1.fam \
--AlleleOrder=alt-first \
--SAIGEOutputFile=WES470k_chr${i} \
--chrom=${i} \
--groupFile=Exome_chr_${i}_groupfile.txt \
--annotation_in_groupTest='missense;lof;synonymous' \
--is_overwrite_output=TRUE \
--sample_include_inLDMat_File=step3_idlist.csv \
--maxMAF_in_groupTest=0.01 ; zip WES470k_step3_chr${i}.zip *.txt ; rm ./*.txt" \
--destination UKB_Main:/WES_470k/SAIGE_results/step3 \
--name step3_chr${i}_full \
-iimage="wzhou88/saige:1.3.0" \
--instance-type=mem2_ssd2_v2_x2 \
-y 
done
