%% Parameters
% grating period in pixel
gp = 100;
% width of grating element in pixel
we = 10;
% number of grating elements in one dimension
ne = 4;

% grayscale factor for plot of the fourier transformed grating 
gf = 100;
% zoom factor for plot of the fourier transformed grating
zf = 5;

% halfwidth of the slit aperture used for spatial filtering in pixel
hsw = 3;

%% setting up the grating as matrix and plot of the grating

% number of pixels in one dimension
px = gp * ( ne - 1 ) + we;
% center position
cp = px/2 + 1;

grating = ones( px );
for z = 0 : ( ne - 1 )
    ma = z * gp + 1 ;
    mb = z * gp + 1 + we;
    grating( ma : mb, : ) = 0;
    grating( :, ma : mb ) = 0;
end

figure;
imagesc( abs( grating ).^2 );
title( 'object plane - grating' );
colormap( gray );
axis image;
xlabel( 'x 1.69e-7 m ' );
ylabel( 'x 1.69e-7 m' );

%% Fourier transform of the grating and plot of the resulting 
% diffraction image

fourgrat = fftshift( fft2( grating ) );

figure;
% maximum value
mv = max( max( abs( fourgrat ) ) )^2;
imagesc( abs( fourgrat ).^2, [ 0 mv/gf ]);
title('diffraction plane - fourier transformed grating');
axis image;
axis( [ cp-px/(2*zf) cp+px/(2*zf) cp-px/(2*zf) cp+px/(2*zf) ] );
colormap( gray );
xlabel( 'pixel' );
ylabel( 'pixel' );

%% spatial filtering and plot of the resulting diffraction image
r = 71;
[xgrid, ygrid] = meshgrid(1:px, 1:px);
mask = ((xgrid-cp).^2 + (ygrid-cp).^2) >= r.^2;
fourgrat(mask) = 0;
%disp(sum(sum(mask == 0)))


figure;
imagesc( abs( fourgrat ).^2, [ 0 mv/gf ]);
title('diffraction plane - spatial filtered fourier transformed grating');
axis image;
axis( [ cp-px/(2*zf) cp+px/(2*zf) cp-px/(2*zf) cp+px/(2*zf) ] );
colormap( gray );
xlabel( 'pixel' );
ylabel( 'pixel' );

%% Inverse fourier transform and plot of the resulting image

btrgrating = ifft2( fourgrat );

figure;
imagesc( abs( btrgrating ).^2 );
title( 'image plane - image of the grating' );
colormap( gray );
axis image;
xlabel( 'pixel' );
ylabel( 'pixel' );
