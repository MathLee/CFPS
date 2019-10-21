clear;
clc;
close all;
%% Producing the segmentatiom map of OSIE-CFPF Testing set
display(['Producing the segmentatiom map of OSIE-CFPF Testing set.']);
mIoU1 = test_sailency_dataset_true_FDM(40000); 

%% Producing the segmentatiom map of GrabCut dataset
display(['Producing the segmentatiom map of GrabCut dataset.']);
mIoU2 = test_sailency_dataset_GrabCut_FDM(40000);
    
