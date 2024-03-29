# Bedload-LHE
 
This Matlab code estimates the sediment transport in an experimental channel by analyzing images of particles crossing a control surface at the outlet of the flume. Along with the calibration process it gives an equivalence between observed particles crossing the surface, and sediment transport. It uses the following toolboxes: Image processing, Image Acquisition, Parallel Computing.

## Pinciple of estimation

The algorithm to estimate sediment transport from images is based in the work originally done by Frey et al. (2003), then adapted by Zimmermann et al. (2008), and lastly by Elgueta-Astaburuaga and Hassan (2017). A mathematical description on how images are used to estimate sediment transport can be found in **this document**.

## Structure of the code

The entire process is divided in three steps of sediment transport computing, and one previous step of image aquisition that is also done with Matlab. The complementary functions allow to analyze intermediate results and which helps, for example, with the calibration process. The code also allows to process selected files, so you can apply the 

- **Step 0 - Acquisition:** This step uses the camera to capture images at a specific frame rate, and store them into Matfiles and/or image files (bmp, jpeg, png, etc.). This step can also be done with any external software that stores images as video files. These videos are also allowed to be processed.

- **Step 1 - Image filtering:** This step takes the images stored as Matfiles or videos in the previous step, and treats them to get a final binary image where particles are easily recognized. 

- **Step 2 - Bead load computation:** This step detects particles and their properties (e.g., area and centroid), filters the most suitable of them to get a mean particle velocity, and computes bed load based on the number of particle-pixels per image and their correspondent mean velocity.

- **Step 3 - Analysis:** A last step of time series analysis to get useful statistics for understanding the characteristics of sediment transport and their evolution in time.

The file tree of the code is shown below. The main folder contains one file per process, as well as one subfolder for each step, where the necessary functions are stored.  
A last ExtraFunctions folder is also included. In this folder there are some useful scripts to see intermediate results (very useful for calibration). An explanation of what they do is available in the ExtraFunctions folder and inside each function file.

```
Bedload 
│
│   S0_Acquisition.m
│   S1_ImageFiltering.m
│   S2_BedloadComputation.m
│   S3_Postprocess.m
│
└───src
    │   README.md
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

The `S0_Acquisition` script is used for recording images from the selected camera. This script generates matfiles containing the images taken by the camera. The code has the option of storing the frames in image file format (e.g., png, jpeg, bitmap or tif).  
The general parameters are set at the beginning of the script, and the camera parameters are predefined inside the *InitiateVideo* function. These parameters depend on which camera is being used for recording (e.g., LESO, Halle, or standard webcams). The general process for using this script is as follows:  
1. First, you need to choose the camera you are going to use. If it is not in the options you can modify the `Initiate video` function parameters and include another option.  
2. Second, you need to set the frames per second (fps) to use. Usually, in the laboratory it should be between 30-60. It depends on the setup and flow discharge conditions.  
3. Third, you have to choose if storing the images as file or not, and their extension. This images are useful during the calibration process, to see the quality of the images and the particles' sharpness.   
4. Last, you have to choose how many images will be stored inside each matfile. In other words, each how many seconds you will produce a new matfile and how big will their size.  
5. Once you press **Run**, the program will ask you for the folder where to store the matfiles. In that path it will create a folder with the date and time as name. Inside, a *RAW_matfiles* subfolder will store the created matfiles filled with images. A logfile where the time of creation of each matfile will be also stored inside.

### Step 1 - Image filtering

The `S1_ImageFiltering` script applies the filtering to RAW images obtained from video acquisition. It works for several matfiles in the same folder or for a single file. The format on which the frames are stored must be chosen at the beginning of the script, as well as the number of files to process (it can process a list of selected files or all files inside a folder).  
As done in the Acquisition step, the source camera of the images must be specified as well. This information will allow to load all the calibrated parameters for the chosen camera already stored in the function `paramsFiltering.m`. 

### Step 2 - Bead load computation


### Step 3 - Analysis

The script for this step is the next task to complete.

## References
- Elgueta-Astaburuaga, M. A., & Hassan, M. A. (2017). Experiment on temporal variation of bed load transport in response to changes in sediment supply in streams. *Water Resources Research*, 53, 763–778. https://doi.org/10.1002/2016wr019460
- Frey, P., Ducottet, C., & Jay, J. (2003). Fluctuations of bed load solid discharge and grain size distribution on steep slopes with image analysis. *Experiments in Fluids*, 35, 589–597. https://doi.org/10.1007/s00348-003-0707-9
- Zimmermann, A. E., Church, M., & Hassan, M. A. (2008). Video-based gravel transport measurements with a flume mounted light table. *Earth Surface Processes and Landforms*, 33, 2285–2296. https://doi.org/10.1002/esp.1675
