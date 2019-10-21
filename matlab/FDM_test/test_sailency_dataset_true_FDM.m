function  mIoU = test_sailency_dataset_true_FDM(iters_num)
%% setting caffe test config
% addpath('/home/lgy/caffe-sal/matlab/');
addpath('/home/lgy/caffe-sal/caffe/matlab/');
use_gpu= 1;
% Set caffe mode
if exist('use_gpu', 'var') && use_gpu
  caffe.set_mode_gpu();
  gpu_id = 1; 
  caffe.set_device(gpu_id);
else
  caffe.set_mode_cpu();
end
% change to your path...
net_model = '/home/lgy/caffe-sal/models/FDM/test_FDMNet.prototxt';
net_weights = fullfile('/home/lgy/caffe-sal/models/FDM' ,['FDMNet_iter_' num2str(iters_num) '.caffemodel']);

phase = 'test'; 
net = caffe.Net(net_model, net_weights, phase);
%% load images from different Datasets
% change to your path....
imPath = '/home/lgy/caffe-sal/models/FDM/OSIE/JPEGimages/';
salPath = '/home/lgy/caffe-sal/models/FDM/OSIE/FDM_test/';
time = 0;
load('/home/lgy/caffe-sal/models/FDM/OSIE/True_GT_N.mat');
%% test each image
for i = 3076 : 3683
    name = num2str( True_GT(i,1) );
    FDMname = num2str( True_GT(i,2) );
    im = imread([imPath name '.jpg']);
    if size(im,3)==1
        im = cat(3,im,im,im);
    end
    if ~exist(fullfile(salPath, name),'dir')
        mkdir(fullfile(salPath, name));
    end
    FDMPath = fullfile('/home/lgy/caffe-sal/models/FDM/OSIE/FDM/',name,'/');
    FDMim = imread([FDMPath FDMname '.png']);
    tic();
    res = net.forward({prepare_image(im), prepare_FDMimage(FDMim)});
    salmap = permute(res{5}(:,:,2), [2 1 3]);
    time = time+toc();
    salmap  = imresize(salmap,[size(im,1) size(im,2)], 'bilinear');
    imwrite(salmap, fullfile(salPath, name, [FDMname '.png']));

end
    fprintf('Speed: %s,\n', time/608*100);
    caffe.reset_all();
    mIoU = Measure_FDM();
end
%% --------------------  prepare images  ---------------------------------
function images = prepare_image(im)
% ------------------------------------------------------------------------
IMAGE_DIM = 288; % Use this resolution for better results
% resize to fixed input size
im = single(im);
im = imresize(im, [IMAGE_DIM IMAGE_DIM], 'bilinear');
im = im(:,:,[3 2 1]);
% subtract mean_data (already in W x H x C, BGR)
im(:,:,1) = im(:,:,1) -104.00699 ;  
im(:,:,2) = im(:,:,2) -116.66877 ;
im(:,:,3) = im(:,:,3) -122.67892 ;
images = permute(im,[2 1 3]);
% ------------------------------------------------------------------------
end
function FDMimages = prepare_FDMimage(FDMim)
% ------------------------------------------------------------------------
IMAGE_DIM = 288; % Use this resolution for better results
% resize to fixed input size
FDMim = single(FDMim);
FDMim = imresize(FDMim, [IMAGE_DIM IMAGE_DIM], 'bilinear');

FDMim = FDMim/255;
FDMimages = permute(FDMim,[2 1]);
% ------------------------------------------------------------------------
end
