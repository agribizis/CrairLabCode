function [sumXY, areaCurve, pixArea, peak]= betaSpreadPos(meanPSF_G, fS, contiguous)
%fS=filter size, default 6
%180906 added nested for loops to remove non-contiguous blocks
%check to see if this function is available anywhere else and compare
%figure out if necessary to normalize
%currently ignoring anything less than zero, double check necessity of this


%fS=6;
sqSz=(fS*2+1)*(fS*2+1);
psf1=meanPSF_G(1:sqSz);
psf1=reshape(psf1, fS*2+1,fS*2+1);

% psf2=meanPSF_G(sqSz+1:sqSz*2);
% psf2=reshape(psf2, fS*2+1,fS*2+1);

psf1(psf1<0)=0;

%addition on 180906

if contiguous==1
    for i=2:(fS*2)
        for j=2:(fS*2)
            if psf1(i+1,j)==0 && psf1(i-1,j)==0 && psf1(i,j-1)==0 && psf1(i,j+1)==0
                psf1(i,j)=0;
            end
        end
    end
end

BW=(psf1>0);
CC = bwconncomp(BW);
%check or find a way to change this so its the largest one
[n,ind]=max(cellfun(@length,(CC.PixelIdxList)));
pix=CC.PixelIdxList{1,ind};
temp=zeros(fS*2+1,fS*2+1);
temp(pix)=1;
figure; imagesc(temp)
pixArea=length(find(temp))
psf1=psf1.*temp;

sumXY=[];
for i=1:(fS*2+1)
    for j=1:(fS*2+1)
        sumXY(i,j)=psf1(i,j)*((i-(fS+1))^2+(j-(fS+1))^2);
    end
end
sumXY=sum(sumXY(:))/sum(psf1(:));
%sigma=round(sumXY^.5);
%psf_t=psf1((fS+1-sigma):(fS+1+sigma),(fS+1-sigma):(fS+1+sigma));


areaCurve=sum(psf1(:));
peak=max(psf1(:));
%pixArea=length(find(psf1));




end