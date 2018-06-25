%check to see if this function is available anywhere else and compare
%figure out if necessary to normalize
%currently ignoring anything less than zero, double check necessity of this


fS=6;
sqSz=(fS*2+1)*(fS*2+1);
psf1=meanPSF_G(1:sqSz);
psf1=reshape(psf1, fS*2+1,fS*2+1);

% psf2=meanPSF_G(sqSz+1:sqSz*2);
% psf2=reshape(psf2, fS*2+1,fS*2+1);

psf1(psf1<0)=0;
sumXY=[];
for i=1:(fS*2+1)
    for j=1:(fS*2+1)
        sumXY(i,j)=psf1(i,j)*((i-(fS+1))^2+(j-(fS+1))^2);
    end
end
sumXY=sum(sumXY(:));