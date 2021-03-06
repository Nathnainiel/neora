////// Helper functions for Neora Live Sampler \\\\\\\\\\\\\\\\

~record = { | channel = -1|
	switch(~globalParams.recordingSource)
	{\input} {
		~recSynth = Synth(\record_buffer, [\bufnum, ~localRecBuffer, \trigID, channel]);
	}
	{\output} {
		~recSynth = Synth(\record_output,
			[\inBus, ~globalParams.masterBus, \bufnum, ~localRecBuffer, \trigID, channel],
			target: ~globalParams.synthGroup, addAction: \addAfter
		);
		"Rec synth created".postln;
	};
	~isRec = true;
};

~stopRecord = { | channel = -1 |
	~recSynth.set(\stopTrig, 1);

	~isRec = false;
};


~reverseReverb = {
	~channels[~currentChannel].reverseReverb();
	{
		~instrWin.normalRevBut.value=0;
		~instrWin.reverseRevBut.value=1;
	}.defer;
};

~normalReverb = {
	~channels[~currentChannel].normalReverb();
	{
		~instrWin.reverseRevBut.value=0;
		~instrWin.normalRevBut.value=1;
	}.defer;
};