# CFPS
   This project provides the code and results for 'Constrained fixation point based segmentation via deep neural network', Neurocomputing 2019. [Paper link](https://www.sciencedirect.com/science/article/pii/S0925231219311890).
   
   Our code is implemented based on the Caffe of Amulet. You can first install and compile the caffe according to the [Amulet](https://github.com/Pchank/caffe-sal). 


# OSIE-CFPS Dataset
   We build a new dataset based on OSIE dataset for 'Constrained Fixation Point based Segmentation' task, you can downlown the dataset [here](https://pan.baidu.com/s/18_Cc2NmbUdhYEaLX2dEHCQ&shfl=sharepset).
  
  OSIE-CFPS contains 3,683 images with corresponding fixation density maps and groundtruths, divided into training set (3,075 images) and testing set (608 images).


# Results on OSIE-CFPS and GrabCut
   We provide results of the compared 7 methods (GrapgCut, RandomEalk, GSC, GBOS, SOS, AVS and SegNet) and our method on 2 datasets: [OSIE-CFPS](https://pan.baidu.com/s/1mXofcSOxrTyjOz-Z-nJtZA&shfl=sharepset) and [GrabCut](https://pan.baidu.com/s/1KbzOwaNwSikw7nJuQJuUbg&shfl=sharepset).

  
# Testing
1. Download the [trained model](https://pan.baidu.com/s/1PJucxmstCjF2Wt7pS9hFmQ&shfl=sharepset) (`FDMNet_iter_40000.caffemodel`), and put it under `models/FDM/`.
2. Run `matlab/FDM_test/test_model.m`.
3. Results of OSIE-CFPS are under `models/FDM/OSIE/binary_FDM_test/`; results of GrabCut are under `models/FDM/GrabCut_database/binary_result/`.


# Citation
        @ARTICLE{Li_2019_NEUCOM,
                author = {Li, Gongyang and Liu, Zhi and Shi, Ran and Wei, Weijie},
                title = {Constrained fixation point based segmentation via deep neural network},
                journal = Neurocomputing,
                volume = {368},
                pages = {180--187},
                year = {2019}}


If you encounter any problems with the code, want to report bugs, etc.

Please contact me at lllmiemie@163.com or ligongyang@shu.edu.cn.
