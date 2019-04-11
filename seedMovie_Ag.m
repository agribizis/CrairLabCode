function [CorMovie]=seedMovie_Ag(Movie, V1_mov,sz);

% filename2 = 'RoiSet.zip';
% [sROI] = ReadImageJROI(filename2);
% sz=[540 640];
% mask=poly2mask(sROI{1,1}.mnCoordinates(:,1), sROI{1,1}.mnCoordinates(:,2),sz(1),sz(2));
% mask=imresize(mask,0.5,'nearest');
% index=find(mask);
% figure; imagesc(mask)
% SCmask=mask;
% mask=poly2mask(sROI{1,2}.mnCoordinates(:,1), sROI{1,2}.mnCoordinates(:,2),sz(1),sz(2));
% mask=imresize(mask,0.5,'nearest');
% figure; imagesc(mask)
% V1mask=mask;
% bothmasks=SCmask+V1mask;
% A = openMovie('02_45post_100x.tif');
% A = imresize(A,0.5,'nearest');
% B = openMovie('02_45post_100x@0001.tif');
% B = imresize(B,0.5,'nearest');
% C = openMovie('02_45post_100x@0002.tif');
% C = imresize(C,0.5,'nearest');
% D = openMovie('02_45post_100x@0003.tif');
% D = imresize(D,0.5,'nearest');
% Movie = cat(3,A,B,C,D);
% sz=size(Movie);
% Movie = reshape(Movie, sz(1)*sz(2),sz(3));
% Movie = Movie ./ (mean(Movie,2) * ones(1,sz(3))) - 1;
% Movie = reshape(Movie,sz);
% V1_mov=Movie.*(bothmasks);
% V1_mov=reshape(V1_mov,sz(1)*sz(2),sz(3));
% 
% A = Movie;
% SVDsimp

% Movie = mov;
% V1_mov=Movie.*(bothmasks);
% [CorMovie]=seedMovie_Ag(Movie, V1_mov,sz);
% implay(CorMovie)
% M(size(CorMovie,3)) = struct('cdata',[],'colormap',[]);
% for fr=1:size(CorMovie,3)
%     [I2, map] = gray2ind(CorMovie(:,:,fr), 8); %figure; imshow(I2,map)
%     M(fr) = im2frame(I2,map);
% end
% writeMovie(M,['CorMovie' datestr(now,'yyyymmdd-HHMMSS') '.avi']);



lengthMov=50;

CorMovie=zeros(sz(1), sz(2), lengthMov); 
V1_mov=reshape(V1_mov,sz(1)*sz(2),sz(3));
for i=1:lengthMov
    pix=squeeze(Movie(155+i,190,:));
    corM=corr(V1_mov',pix);
    corM=reshape(corM',sz(1),sz(2));
    CorMovie(:,:,i)=corM;    
end



end