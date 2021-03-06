s = Server.local.boot;

b = Buffer.alloc(s,2048,1);

(
SynthDef("help-noopFFT", { arg out=0,bufnum=0;
	var in, chain;
	in = WhiteNoise.ar(0.01);
	chain = FFT(bufnum, in);
	chain.inspect; // its an FFT
	Out.ar(out,
		IFFT(chain) // inverse FFT
	);
}).play(s,[\out,0,\bufnum,b.bufnum]);
)

(
SynthDef("help-sineFFT", { arg out=0,bufnum=0;
	var in, chain;
	in = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08,0,6,6.2).squared, 0, 100,800));
	chain = FFT(bufnum, in);
	Out.ar(out, IFFT(chain));
}).play(s,[\out,0,\bufnum,b.bufnum]);
)

(
SynthDef("help-magAbove", { arg out=0,bufnum=0;
	var in, chain;
	in = SinOsc.ar(SinOsc.kr(SinOsc.kr(0.08,0,6,6.2).squared, 0, 100,800));
	//in = WhiteNoise.ar(0.2);
	chain = FFT(bufnum, in);
	chain = PV_MagAbove(chain, 310);
	Out.ar(out, 0.5 * IFFT(chain));
}).play(s,[\out,0,\bufnum,b.bufnum]);
)

(
SynthDef("help-brick", { arg out=0,bufnum=0;
	var in, chain;
	in = WhiteNoise.ar(0.2);
	chain = FFT(bufnum, in);
	chain = PV_BrickWall(chain, SinOsc.kr(0.1));
	Out.ar(out, IFFT(chain));
}).play(s,[\out,0,\bufnum,b.bufnum]);
)

(
SynthDef("help-randcomb", { arg out=0,bufnum=0;
	var in, chain;
	in = WhiteNoise.ar(0.8);
	chain = FFT(bufnum, in);
	chain = PV_RandComb(chain, 0.95, Impulse.kr(0.4));
	Out.ar(out, IFFT(chain));
}).play(s,[\out,0,\bufnum,b.bufnum]);
)

(
SynthDef("help-rectcomb", { arg out=0,bufnum=0;
	var in, chain;
	in = WhiteNoise.ar(0.2);
	chain = FFT(bufnum, in);
	chain = PV_RectComb(chain, 8, LFTri.kr(0.097,0,0.4,0.5),
		LFTri.kr(0.24,0,-0.5,0.5));
	Out.ar(out, IFFT(chain));
}).play(s,[\out,0,\bufnum,b.bufnum]);
)

(
SynthDef("help-magFreeze", { arg out=0,bufnum=0;
	var in, chain;
	in = SinOsc.ar(LFNoise1.kr(5.2,250,400));
	chain = FFT(bufnum, in);
	// moves in and out of freeze
	chain = PV_MagFreeze(chain, SinOsc.kr(0.2) );
	Out.ar(out, 0.5 * IFFT(chain));
}).play(s,[\out,0,\bufnum,b.bufnum]);
)