Fs=4800;Channels=1;bits=16;
%record audio
r=audiorecorder(Fs,bits,Channels);
duration=5;display('Recording Started');
recordblocking(r,duration);
disp('Recording Stopped');
x=getaudiodata(r);
%plotting
t=0:1/Fs:(length(x)-1)/Fs;
subplot(2,1,1);plot(t,x,'LineWidth',1.5);
xlabel('time(sec)');ylabel('Amplitude');
title('Time Domain plot of the recorded signal');
%get fft
n=length(x);F=0:(n-1)*Fs/n;
Y=fft(x,n);
plotting
F_0=(-n/2:n/2-1).*(Fs/n);
Y_0=fftshift(Y);
AY_0=abs(Y_0);
subplot(2,1,2);plot(F_0,AY_0,'linewidth',1.5);
xlabel('Freq');ylabel('amp');
title('fre domain plot of auduo signal');

filename='bruh.wav';
audiowrite(filename,x,Fs);



[xsignal,fs1]=audioread("wgn.wav");
xsignal=xsignal(1:fs1,1);
[ysignal,fs2]=audioread(filename);


start=fix(size(ysignal,1)*(1/3));
ysignal=ysignal(start:start+fs1-1);
xfft=fft(xsignal);
yfft=fft(ysignal);
hfft=yfft./xfft;
h=abs(ifft(hfft));

p=xsignal;

x=linspace(0,size(p,1),size(p,1));
plot(x,p);hold on;
p=ysignal;plot(x,p);

pks=findpeaks(h);
[peak1,I1]=max(pks);
pks(I1)=0;
[peak2,I2]=max(pks);

distance=abs((I1/4000)-(I2/4000)*343);
distance=distance/2;
distance=distance/100;
