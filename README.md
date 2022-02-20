# Bedload-LHE
 
This Matlab code estimates the sediment transport in an experimental channel by analyzing images of particles crossing a control surface at the outlet of the flume. Along with the calibration process it gives an equivalence between observed particles crossing the surface, and sediment transport.

## Pinciple of estimation

The algorithm to estimate sediment transport from images is based in the work originally done by Frey et al. (2003), then adapted by Zimmermann et al. (2008), and lastly by Elgueta-Astaburuaga and Hassan (2017). A mathematical description on how images are used to estimate sediment transport can be found in **this document**.

## Structure of the code

The entire process is divided in three steps of sediment transport computing, and one previous step of image aquisition that is also done with Matlab.

- **Step 0 - Acquisition:** This step uses the camera to capture images at a specific frame rate, and store them into Matfiles and/or image files (bmp, jpeg, png, etc.). This step can also be done with any external software that stores images as video files. These videos are also allowed to be processed.

- **Step 1 - Image filtering:** This step takes the images stored as Matfiles or videos in the previous step, and treats them to get a final binary image where particles are easily recognized. 

- **Step 2 - Bead load computation:** This step detects particles and their properties (e.g., area and centroid), filters the most suitable of them to get a mean particle velocity, and computes bed load based on the number of particle-pixels per image and their correspondent mean velocity.

- **Step 3 - Analysis:** A last step of time series analysis to get statistics useful for understanding the characteristics of sediment transport in time.


```
Bead load 
│
│   S0_Acquisition.m
│   S1_ImageFiltering.m
│   S2_BedloadComputation.m
│   S3_Postprocess.m
│
└───src
    │   README.md
    │
    │
    │
    ├───S0
    │       closing.m
    │       FrameToMatfile.m
    │       InitiateVideo.m
    │       Recording.m
    │       S0dir.m
    │       SaveFrames.m
    │       stopVideo.m
    │       writeImage.m
    │
    ├───S1
    │       ExportFiltered.m
    │       Filtering.m
    │       FiltersFunction.m
    │       paramsFiltering.m
    │       S1dir.m
    │       TrimImage.m
    │
    ├───S2
    │       Black_surface.m
    │       Discharge_computation.m
    │       Matching.m
    │       Mean_vel.m
    │       Particles_info.m
    │       Particle_detection.m
    │       Particle_filtering.m
    │       S2dir.m
    │
    ├───S3
    │       im2vid.m
    │       Plot_centroids.m
    │       Plot_velocity.m
    │        
    └───ExtraFunctions
            im2animation.m
            im2mat.m
            im2vid.m
            loadtiff.m
            plot_centroids.m
            plot_velocity.m
            saveastiff.m
            vid2mat.m
            README.md

```

## Usage

For each step of the process there is a script 

### Step 0 - Acquisition


### Step 1 - Image filtering


### Step 2 - Bead load computation


### Step 3 - Analysis



## References
- Elgueta-Astaburuaga, M. A., & Hassan, M. A. (2017). Experiment on temporal variation of bed load transport in response to changes in sediment supply in streams. Water Resources Research, 53, 763–778. https://doi.org/10.1002/2016wr019460
- Frey, P., Ducottet, C., & Jay, J. (2003). Fluctuations of bed load solid discharge and grain size distribution on steep slopes with image analysis. Experiments in Fluids, 35, 589–597. https://doi.org/10.1007/s00348-003-0707-9
- Zimmermann, A. E., Church, M., & Hassan, M. A. (2008). Video-based gravel transport measurements with a flume mounted light table. Earth Surface Processes and Landforms, 33, 2285–2296. https://doi.org/10.1002/esp.1675
