%--------------------------------------------------------------------------
% extract_low_level_features Extracts low level features ()from bounding
% boxes
%   feats = extract_low_level_features(dirs,odir)
%
%   Input -----
%      'dirs': cell array of paths to extracted bounding boxes
%      'odir': directory to code files
%      'acum': average image sizes for each dataset
%
%   Output -----
%      'feats': Cell array of low level features
%--------------------------------------------------------------------------
function feats = extract_low_level_features(dirs,odir,acum)
    feats = {};

    for i = 1:numel(dirs)
        cd(dirs{i}); d = dir; d = {d.name}; d = d(3:end);
        feat = [];

        for j = 1:numel(d)
            im = imread(d{j});

            % Extract average RGB colours and histogram of colour features
            cd(odir);
            fstr = 'RGB'; blocks = 9; bins = 16;
            x1 = fox_get_features(im,fstr,blocks,bins);
            fstr2 = 'H'; x2 = fox_get_features(im,fstr2,blocks,bins);

            % Extract HOG features
            i2 = imresize(im,[round(acum(i,1)) round(acum(i,2))]);
            [y,vis] = extractHOGFeatures(i2,'CellSize',[32 32]);

            % Extract LBP features
            i3 = rgb2gray(i2);
            z = extractLBPFeatures(i3);

            % Collate features for this video
            feat = [feat; x1 x2 y z];
            cd(dirs{i});
        end
        % Collate features from all videos for output
        feats = [feats; feat];
        cd(odir);
    end
