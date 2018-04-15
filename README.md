# Implementation of "FrameBreak: Dramatic Image Extrapolation by Guided Shift-Maps"

## Team: Honest Liars

- Akanksha Baranwal
- Parv Parkhiya
- Yogesh Sharma

## To run the algo

- Run main.m which will pick top translation for discretize transformation

- Run pre_pro_alpha.m to generate input files of uninary cost and smootheness cost for alpha expansion

- Run ./gco-v3.0/parv_build/alpha_exp to run 20 independent alpha exanpsion to generate respective shift map

- Run ./gco-v3.0/parv_build/alpha_exp_final to run final alpha expansion to generate transformation map 

- Run recontruct.m file to finally generate reconstructed image


## github repo link

- https://github.com/parvparkhiya/Dramatic_Image_Extrapolation_Implementation/
