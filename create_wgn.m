fs=4800;
windowsize=4800;
rep=10;
sos=343;
xsignal=wgn(windowsize,1,0);
xsignal_=repmat(xsignal,50);
audiowrite("wgn.wav",xsignal,fs)
