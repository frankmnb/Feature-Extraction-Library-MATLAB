%--------------------------------------------------------------------------
% visualise_features Creates a figure with side-by-side comparison of
% features, reduced in dimensionailty to 2 features using t-sne
%   [] = visualise_features(files,llf,hlf,gt)
%
%   Input -----
%      'files': cell array of names of the videos
%      'llf': low-level features
%      'hlf': high-level features
%      'gt': flag for displaying GT (with coloured labels) or TR (uniform)
%
%   Output -----
%      ' ': A figure of size num_videos*2 visualising the high- and low-
%      level features
%--------------------------------------------------------------------------
function [] = visualise_features(files,llf,hlf,gt)
    x = numel(files);

    if gt == true
        for i = 1:x
            tic
            labels = llf{i};
            labels = labels(:,end);
            dl = llf{i}; dl = tsne(dl(:,1:end-1)); dh = tsne(hlf{i});
            data_l = [dl labels]; data_h = [dh labels];

            subplot(2,x,i);
            gscatter(data_l(:,1),data_l(:,2),data_l(:,3))
            title(strcat(num2str(files{i}),' - Colour'))

            subplot(2,x,(i+x));
            gscatter(data_h(:,1),data_h(:,2),data_h(:,3))
            title(strcat(num2str(files{i}),' - CNN')) 
            toc
        end
    else
        for i = 1:x
            tic
            data_l = llf{i}; data_l = tsne(data_l(:,1:end-1));
            data_h = tsne(hlf{i});

            subplot(2,x,i);
            scatter(data_l(:,1),data_l(:,2),'k.')
            title(strcat(num2str(files{i}),' - Colour'))

            subplot(2,x,(i+x));
            scatter(data_h(:,1),data_h(:,2),'k.')
            title(strcat(num2str(files{i}),' - CNN'))
            toc
        end
    end